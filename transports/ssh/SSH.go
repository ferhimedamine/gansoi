package ssh

import (
	"bytes"
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/pem"
	"errors"
	"fmt"
	"io"
	"io/ioutil"
	"net"
	"sync"

	"github.com/gansoi/gansoi/database"
	"github.com/gansoi/gansoi/logger"

	"golang.org/x/crypto/ssh"
)

type (
	// SSH is a transport using ordinary SSH access.
	SSH struct {
		database.Object `storm:"inline"`

		Host     string `json:"host" description:"Hostname or IP adress to connect to"`
		Port     uint16 `json:"port" description:"TCP port to connect to" default:"22"`
		Username string `json:"username" description:"Username"`
	}

	// This is a cheap hack to use database.Database as a key/value store for
	// our private key.
	keyStorage struct {
		ID       string `storm:"id"`
		PemBytes []byte
	}
)

var (
	signerLock sync.Mutex
	signer     ssh.Signer

	// ErrNotReady will be returned if the SSH transport is not ready when
	// calling Connect.
	ErrNotReady = errors.New("ssh transport is not ready")
)

func init() {
	database.RegisterType(SSH{})
	database.RegisterType(keyStorage{})
}

// generateKey generates a 2048 bit RSA key for SSH. It returns the PEM encoded
// key content.
func generateKey() []byte {
	// Generate RSA key.
	rsaKey, _ := rsa.GenerateKey(rand.Reader, 2048)

	// Encode RSA key to PEM format.
	var pemBuffer bytes.Buffer
	pem.Encode(&pemBuffer, &pem.Block{
		Type:  "RSA PRIVATE KEY",
		Bytes: x509.MarshalPKCS1PrivateKey(rsaKey),
	})

	return pemBuffer.Bytes()
}

// Init will initiate internal structures for the SSH transport including
// generating a private key.
func Init(db database.Database) error {
	signerLock.Lock()
	defer signerLock.Unlock()

	ks := keyStorage{ID: "rsa-key"}

	err := db.One("ID", ks.ID, &ks)
	if err == database.ErrNotFound {
		ks.PemBytes = generateKey()

		err = db.Save(&ks)
	}

	if err != nil {
		return err
	}

	// Parse private key for ssh
	signer, err = ssh.ParsePrivateKey(ks.PemBytes)
	if err != nil {
		return err
	}

	return nil
}

// PublicKey will generate a public key formatted for use in ~/.ssh/authorized_keys.
func PublicKey() string {
	signerLock.Lock()
	defer signerLock.Unlock()

	if signer == nil {
		return ""
	}

	// Generate nice string for ~/.ssh/authorized_keys
	return string(bytes.TrimSpace(ssh.MarshalAuthorizedKey(signer.PublicKey()))) + " https://gansoi.com/\n"
}

// Connect to a remote ssh server using public key authentication
func (s *SSH) connect() (*ssh.Client, error) {
	signerLock.Lock()
	defer signerLock.Unlock()

	dialString := fmt.Sprintf("%s:%d", s.Host, s.Port)
	logger.Debug("ssh", "Connecting to %s as %s", dialString, s.Username)

	if signer == nil {
		return nil, ErrNotReady
	}

	config := &ssh.ClientConfig{
		User:            s.Username,
		Auth:            []ssh.AuthMethod{ssh.PublicKeys(signer)},
		HostKeyCallback: ssh.InsecureIgnoreHostKey(), // FIXME
	}

	client, err := ssh.Dial("tcp", dialString, config)
	if err != nil {
		return nil, err
	}

	return client, nil
}

// Dial implements transports.Transport.
func (s *SSH) Dial(network string, address string) (net.Conn, error) {
	return nil, errors.New("Dial() not implemented")
}

// Exec executes a binary on the remote host.
func (s *SSH) Exec(cmd string, arguments ...string) (io.Reader, io.Reader, error) {
	for _, arg := range arguments {
		cmd += " " + arg
	}

	logger.Debug("ssh", "Executing command '%s' on %s:%d as %s", cmd, s.Host, s.Port, s.Username)
	conn, err := connect(*s)
	if err != nil {
		return nil, nil, err
	}
	defer done(*s)

	session, err := conn.NewSession()
	if err != nil {
		return nil, nil, err
	}
	defer session.Close()

	var stdoutBuf, stderrBuf bytes.Buffer
	session.Stdout = &stdoutBuf
	session.Stderr = &stderrBuf

	err = session.Run(cmd)
	if err != nil {
		return &stdoutBuf, &stderrBuf, err
	}

	return &stdoutBuf, &stderrBuf, nil
}

// Open will open a remote file for reading.
func (s *SSH) Open(path string) (io.ReadCloser, error) {
	// Cat is not much worse than scp for single files. "scp -t" will also
	// spawn a process. Cat will do just fine for now. Maybe at some future
	// point, we could implement a persistent SCP client..?
	r, _, err := s.Exec("/bin/cat", path)

	return ioutil.NopCloser(r), err
}

// ReadFile will read a complete file from the remote.
func (s *SSH) ReadFile(path string) ([]byte, error) {
	r, err := s.Open(path)
	if err != nil {
		return nil, err
	}

	return ioutil.ReadAll(r)
}