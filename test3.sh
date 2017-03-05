#!/bin/sh

# Run this locally and visit https://gansoi-dev.com:9002/ in your favorite
# browser.

mkdir /tmp/gansoi-dev

# Certificate
cat >/tmp/gansoi-dev/cert.pem <<EOF
-----BEGIN CERTIFICATE-----
MIIFczCCBFugAwIBAgIQAYdAdtYc/yHec/7saKg3XTANBgkqhkiG9w0BAQsFADBC
MQswCQYDVQQGEwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5jLjEbMBkGA1UEAxMS
UmFwaWRTU0wgU0hBMjU2IENBMB4XDTE2MTAwNTAwMDAwMFoXDTE3MTAwNTIzNTk1
OVowGzEZMBcGA1UEAwwQKi5nYW5zb2ktZGV2LmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBALTDvIJh3UidNxnqV9St2dJDmaNSEtHncq8wtir23xX7
qU4cbkvwc8IQuMbsUAdUGyRPqKHQpAzPLPIuWMrMb4fyxjBAIezm5WeQY9uFhf5U
iXN3TTIlQg6TA0OTbblIV7tajYZ8s2mUIKdvix7YRZKWEbQwffvH1g5riy1UAi97
gZC0JzjQheh8UL25n1eatw6cAt7UMBo18T4kn6ZlLoPxscfzxKswt9ugyXy5U5Q3
Bz4wyknzQ6dHLJ/dNqvb0jtZOCA2MtbVLFucrAwCLggfVhj47o655BspEXq3eRyO
VbWYne4V9wXlAR+me2e6R4aWSkj7S/6kBSG+7vMMDWUCAwEAAaOCAoowggKGMCsG
A1UdEQQkMCKCECouZ2Fuc29pLWRldi5jb22CDmdhbnNvaS1kZXYuY29tMAkGA1Ud
EwQCMAAwKwYDVR0fBCQwIjAgoB6gHIYaaHR0cDovL2dwLnN5bWNiLmNvbS9ncC5j
cmwwbwYDVR0gBGgwZjBkBgZngQwBAgEwWjAqBggrBgEFBQcCARYeaHR0cHM6Ly93
d3cucmFwaWRzc2wuY29tL2xlZ2FsMCwGCCsGAQUFBwICMCAMHmh0dHBzOi8vd3d3
LnJhcGlkc3NsLmNvbS9sZWdhbDAfBgNVHSMEGDAWgBSXwidQnsLJ7AyIMsh8reKm
AU/abzAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUF
BwMCMFcGCCsGAQUFBwEBBEswSTAfBggrBgEFBQcwAYYTaHR0cDovL2dwLnN5bWNk
LmNvbTAmBggrBgEFBQcwAoYaaHR0cDovL2dwLnN5bWNiLmNvbS9ncC5jcnQwggED
BgorBgEEAdZ5AgQCBIH0BIHxAO8AdgDd6x0reg1PpiCLga2BaHB+Lo6dAdVciI09
EcTNtuy+zAAAAVeV5eNpAAAEAwBHMEUCIDfjN2FPpp9IQmH4GHoXFt6m2Zpnh53P
KFqDNdnKV9RgAiEAyzR+PRfIVEAthACr7JNrnMzcRO0xerv7XfmnIZfTIq0AdQBo
9pj4H2SCvjqM7rkoHUz8cVFdZ5PURNEKZ6y7T0/7xAAAAVeV5eOAAAAEAwBGMEQC
IAmQ6r1H4O0Di0C4xQ2gBhoenbsVejtd3EnL5ddYZav8AiB5tK6cXfDB3K4e8m3u
ArLae2XACKMNsYjOlbaAsmp1pzANBgkqhkiG9w0BAQsFAAOCAQEAbHnLGGbucDZV
B697kCFkeZAVUJWAVKACEs+T3Tya5DWUbJIBRmAXprUp64kcT92KC/N2wSXfE4qj
q1G4hEK3TjWaAeu26V/+tPLGNXa6HwpTIuVnENIrEQ7vnQYp6Q9zOieGobhGUP47
1vPsCKYEzggi7nN1jQOJEKpBm14332vu2tsS1EgsPbGon/+xdkojeWJ3nbrgcrK/
mMYOrNvq1ikQ+PcOdAnULwJklMExdjkRT/p+TizF9Nw3/7i2X6T9TYZ1lQYyfGC4
Bqa7BzipeYqlnCR75GGnkbTP3OPWkGpLMTTokyV9libM+LaGshgL1up0t5QQ/kFF
cOhykCUsFg==
-----END CERTIFICATE-----
EOF

# Intermediate
cat >>/tmp/gansoi-dev/cert.pem <<EOF
-----BEGIN CERTIFICATE-----
MIIETTCCAzWgAwIBAgIDAjpxMA0GCSqGSIb3DQEBCwUAMEIxCzAJBgNVBAYTAlVTMRYwFAYDVQQK
Ew1HZW9UcnVzdCBJbmMuMRswGQYDVQQDExJHZW9UcnVzdCBHbG9iYWwgQ0EwHhcNMTMxMjExMjM0
NTUxWhcNMjIwNTIwMjM0NTUxWjBCMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5j
LjEbMBkGA1UEAxMSUmFwaWRTU0wgU0hBMjU2IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAu1jBEgEul9h9GKrIwuWF4hdsYC7JjTEFORoGmFbdVNcRjFlbPbFUrkshhTIWX1SG5tmx
2GCJa1i+ctqgAEJ2sSdZTM3jutRc2aZ/uyt11UZEvexAXFm33Vmf8Wr3BvzWLxmKlRK6msrVMNI4
/Bk7WxU7NtBDTdFlodSLwWBBs9ZwF8w5wJwMoD23ESJOztmpetIqYpygC04q18NhWoXdXBC5VD0t
A/hJ8LySt7ecMcfpuKqCCwW5Mc0IW7siC/acjopVHHZDdvDibvDfqCl158ikh4tq8bsIyTYYZe5Q
Q7hdctUoOeFTPiUs2itP3YqeUFDgb5rE1RkmiQF1cwmbOwIDAQABo4IBSjCCAUYwHwYDVR0jBBgw
FoAUwHqYaI2J+6sFZAwRfap9ZbjKzE4wHQYDVR0OBBYEFJfCJ1CewsnsDIgyyHyt4qYBT9pvMBIG
A1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6
Ly9nMS5zeW1jYi5jb20vY3Jscy9ndGdsb2JhbC5jcmwwLwYIKwYBBQUHAQEEIzAhMB8GCCsGAQUF
BzABhhNodHRwOi8vZzIuc3ltY2IuY29tMEwGA1UdIARFMEMwQQYKYIZIAYb4RQEHNjAzMDEGCCsG
AQUFBwIBFiVodHRwOi8vd3d3Lmdlb3RydXN0LmNvbS9yZXNvdXJjZXMvY3BzMCkGA1UdEQQiMCCk
HjAcMRowGAYDVQQDExFTeW1hbnRlY1BLSS0xLTU2OTANBgkqhkiG9w0BAQsFAAOCAQEANevhiyBW
lLp6vXmp9uP+bji0MsGj21hWID59xzqxZ2nVeRQb9vrsYPJ5zQoMYIp0TKOTKqDwUX/N6fmS/Zar
RfViPT9gRlATPSATGC6URq7VIf5Dockj/lPEvxrYrDrK3maXI67T30pNcx9vMaJRBBZqAOv5jUOB
8FChH6bKOvMoPF9RrNcKRXdLDlJiG9g4UaCSLT+Qbsh+QJ8gRhVd4FB84XavXu0R0y8TubglpK9Y
Ca81tGJUheNI3rzSkHp6pIQNo0LyUcDUrVNlXWz4Px8G8k/Ll6BKWcZ40egDuYVtLLrhX7atKz4l
ecWLVtXjCYDqwSfC2Q7sRwrp0Mr82A==
-----END CERTIFICATE-----
EOF

# Key
cat >/tmp/gansoi-dev/key.pem <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAtMO8gmHdSJ03GepX1K3Z0kOZo1IS0edyrzC2KvbfFfupThxu
S/BzwhC4xuxQB1QbJE+oodCkDM8s8i5Yysxvh/LGMEAh7OblZ5Bj24WF/lSJc3dN
MiVCDpMDQ5NtuUhXu1qNhnyzaZQgp2+LHthFkpYRtDB9+8fWDmuLLVQCL3uBkLQn
ONCF6HxQvbmfV5q3DpwC3tQwGjXxPiSfpmUug/Gxx/PEqzC326DJfLlTlDcHPjDK
SfNDp0csn902q9vSO1k4IDYy1tUsW5ysDAIuCB9WGPjujrnkGykRerd5HI5VtZid
7hX3BeUBH6Z7Z7pHhpZKSPtL/qQFIb7u8wwNZQIDAQABAoIBAFc3ngv2tjMkEAME
C+7FFzUZgtbHcecvWilnQm4GgWr06yKSGzGuyduX/9+TA6YVkab6fG3e4lh/2brc
W+E1tJaOr8t2Fihc29EVXOj9SsKE/XDl3ixUx8OKcWe4iZd9bT8rmN+L6XEGlJ7U
9fYi+aaZm98qCo9iQ0jf4N41C3zmtN2iXq8qoXqa9ad/RMAa8I17Yil6m/YRAZac
3VxSH7GVYyia8c983I9Pdrkk1iLJbpNDXAbs6eA6ioEkPB4B0GJywVcpdOLQwxOW
7aE+XnZLooQkMrf4yZbSfMAGyp3NidXel93U4jrkmc26nEZKBHQo6DsY/J5ZVSl0
iB7rcP0CgYEA7gKEr2L0XJtIy33/S9PIFA1D6wo0We589ieeav7H/EqPClG3p1Fq
RCsLitXgAjXNCBkLn09Yi5lP5nVO2HkkJfBFp1rwHKdIFdLC2LivzhF2qkLnFOBt
h6KnbRLc90SfzlLwb0+gffVC26cldKNa4iz89Kd1gy3rR2OhXIhDUT8CgYEAwm2G
U4dy5LYYmX44eWzIz6R+L+aXSrjHB6wNNG0yxH6xjwlgcAGUzrwWSOeBlqwx2Uh5
5abL1pt2YbPyBrZGsyogArZ30b2tYBMi/Hm4d2M7ZP2tV02nUnFuE/JWXnnQ2i2/
M2qZQZgBjP15v4pQjuedM3+n3tNHxF3l/TCq1FsCgYBU0Hzr6v1dStDEAyBIqy1v
R9LeHQLO0VeieDfRtP0bAI68hKZHb5HIvPYeAV0ULIvlyNcFbEcHaBi67S6toW2q
P1by7ksGSu47KKHajOXJLxv0TGcAX4FohiPXkJNBYij4Y0HeyKdOe2nZ0FRenh+y
3Yk+vbX4ixJ+nBhSWxRyDQKBgHpaJkAGav0WwuBFGBEBrlVNNMO8HtU89rMTSLQH
S/1vpRlYU0HpHNYEcxmp5lkFP9F21I76qigBaTwO223x4wf4qHBMl5Z8ANEG+etc
RgOLhOMG6MCZ84PkMduHk2aczhue0kXu/UbT+5XYJXet+QgVJU41NVT6LJ2cYZE1
wSslAoGBAOk5UUTHm+HVy17ztc38moMKsqDmEFvLcLFoiGqdZhHgouw+gUQg21Uy
o+7hG62xVvzquorK1CB0MKx92GIyGtk0319Ta0bt6oWwe/MoLtslgcYbjk8UdN5P
/eElJPzec9D3uSLCUihW5O8AjcrYOsTZftRnIQTxuaF2eobj0sLR
-----END RSA PRIVATE KEY-----
EOF

cat >/tmp/gansoi-dev/node1.conf <<EOF
bind = "127.0.0.1:4934"
datadir = "/tmp/gansoi-dev/node1-data"

[http]
bind = "node1.gansoi-dev.com:9002"
hostnames = [ "gansoi-dev.com", "node1.gansoi-dev.com" ]
cert = "/tmp/gansoi-dev/cert.pem"
key = "/tmp/gansoi-dev/key.pem"

[redirect]
bind = ""
EOF

cat >/tmp/gansoi-dev/node2.conf <<EOF
bind = "127.0.0.2:4934"
datadir = "/tmp/gansoi-dev/node2-data"

[http]
bind = "node2.gansoi-dev.com:9002"
hostnames = [ "gansoi-dev.com", "node2.gansoi-dev.com" ]
cert = "/tmp/gansoi-dev/cert.pem"
key = "/tmp/gansoi-dev/key.pem"

[redirect]
bind = ""
EOF

cat >/tmp/gansoi-dev/node3.conf <<EOF
bind = "127.0.0.3:4934"
datadir = "/tmp/gansoi-dev/node3-data"

[http]
bind = "node3.gansoi-dev.com:9002"
hostnames = [ "gansoi-dev.com", "node3.gansoi-dev.com" ]
cert = "/tmp/gansoi-dev/cert.pem"
key = "/tmp/gansoi-dev/key.pem"

[redirect]
bind = ""
EOF

mkdir /tmp/gansoi-dev/node1-data
mkdir /tmp/gansoi-dev/node2-data
mkdir /tmp/gansoi-dev/node3-data

./gansoi core --config /tmp/gansoi-dev/node1.conf init
TOKEN=$(./gansoi core --config /tmp/gansoi-dev/node1.conf print-token 2>/dev/null)

export DEBUG=*

# Start first server
tmux new-session -d './gansoi core --config /tmp/gansoi-dev/node1.conf run; sleep 10'

sleep 3
./gansoi core --config /tmp/gansoi-dev/node2.conf join 127.0.0.1 $TOKEN
tmux split-window -v './gansoi core --config /tmp/gansoi-dev/node2.conf run; sleep 10'

sleep 3
./gansoi core --config /tmp/gansoi-dev/node3.conf join 127.0.0.1 $TOKEN
tmux split-window -v './gansoi core --config /tmp/gansoi-dev/node3.conf run; sleep 10'

tmux -2 attach-session -d