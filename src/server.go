package main

import (
	"fmt"
	"net/http"

	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()
	e.GET("/api/v1/ping", func(c echo.Context) error {
		fmt.Println("ini log ya...")
		return c.JSON(http.StatusOK, struct {
			Status  string
			Version string
		}{Status: "Ok!", Version: "v0.0.2"})
	})

	e.GET("/api/v1/hello-again", func(c echo.Context) error {
		return c.JSON(http.StatusOK, struct{ Status string }{Status: "Hello!"})
	})

	e.Logger.Fatal(e.Start(":8080"))
}
