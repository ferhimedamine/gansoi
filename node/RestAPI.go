package node

import (
	"net/http"
	"reflect"

	"github.com/gansoi/gansoi/database"
	"github.com/gin-gonic/gin"
)

type (
	// RestAPI is a generic way to build a REST-based API for the cluster
	// database.
	RestAPI struct {
		db  database.Database
		typ reflect.Type
	}
)

// NewRestAPI will instantiate a new RestAPI.
func NewRestAPI(typ interface{}, db database.Database) *RestAPI {
	return &RestAPI{
		db:  db,
		typ: reflect.TypeOf(typ),
	}
}

func (r *RestAPI) new() interface{} {
	return reflect.New(r.typ).Interface()
}

func (r *RestAPI) list(c *gin.Context) {
	// Reflect is so beautiful. This will create a pointer to a slice of typ's.
	// Please see: http://stackoverflow.com/a/25386460/1156537
	list := reflect.New(reflect.MakeSlice(reflect.SliceOf(r.typ), 0, 0).Type()).Interface()

	err := r.db.All(list, -1, 0, false)
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
		return
	}

	c.JSON(http.StatusOK, list)
}

func (r *RestAPI) create(c *gin.Context) {
	record := r.new()
	err := c.BindJSON(record)
	if err != nil {
		c.AbortWithError(http.StatusBadRequest, err)
		return
	}

	validator, ok := record.(database.Validator)
	if ok {
		err = validator.Validate(r.db)
		if err != nil {
			c.AbortWithError(http.StatusBadRequest, err)
			return
		}
	}

	err = r.db.Save(record)
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
		return
	}

	obj, valid := record.(database.IDSetter)
	if valid {
		c.Data(http.StatusAccepted, "text/plain", []byte(obj.GetID()))
		return
	}

	c.Data(http.StatusAccepted, "text/plain", []byte("got it, thanks\n"))
}

func (r *RestAPI) replace(c *gin.Context) {
	// For now we simply treat this as a create. Should be safe.
	r.create(c)
}

func (r *RestAPI) delete(c *gin.Context) {
	record := r.new()
	err := r.db.One("ID", c.Param("id"), record)
	if err != nil {
		c.AbortWithError(http.StatusNotFound, err)
		return
	}

	err = r.db.Delete(record)
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
		return
	}

	c.Data(http.StatusAccepted, "text/plain", []byte("deleted"))
}

// Router can be used to assign a Gin routergroup.
func (r *RestAPI) Router(router *gin.RouterGroup) {
	router.GET("/", r.list)
	router.POST("", r.create)
	router.PUT("/:id", r.replace)
	router.DELETE("/:id", r.delete)
}
