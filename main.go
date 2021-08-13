package main

import (
	"database/sql"
	"fmt"

	_ "github.com/mattn/go-oci8"
)

const (
	userName = "admin"
	passWd   = "calvin1729"
)

func main() {
	fmt.Println("main")
	openString := "admin/calvin1729@go-oracle.cge5lnejwvuh.us-east-2.rds.amazonaws.com:1521/ORCL"

	db, err := sql.Open("oci8", openString)
	if err != nil {
		fmt.Printf("Open error is not nil: %v", err)
		return
	}
	if db == nil {
		fmt.Println("db is nil")
		return
	}
	err = db.Ping()
	if err != nil {
		fmt.Printf("Conn error %v", db)
	}
	fmt.Printf("OK")
}
