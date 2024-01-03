package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
)

type Person struct {
	Name string `json:"name"`
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Please provide a json argument {\"name\": \"John\"}")
		return
	}
	inJsonString := os.Args[1]

	var person Person
	err := json.Unmarshal([]byte(inJsonString), &person)
	if err != nil {
		log.Fatal(err)
	}

	var outJsonString []byte
	outJsonString, err = json.Marshal(person)
	fmt.Println(string(outJsonString))
}
