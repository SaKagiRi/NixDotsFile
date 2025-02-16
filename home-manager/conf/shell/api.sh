#! /bin/bash

if [ $# -lt 3 ]; then
	echo "Usage: ./api.sh [option] <api> <endpoint> <input>
	Options:
	  get     -g 
	  post    -p
	  push    -u
	  delete  -d
	api:
	  ord        order
	  int        internal-login
	  fin        finance
	  asm        assembly
	  pic        picking
	  stc        stock
	  aut        auth
	  "
	exit 1
fi

method=""
api=""

get() {
	token=$(curl -X POST "https://api51000.jibcom.dev/internal-login/api/v1/login" -H "Content-Type: application/json" -d '{"username":"sale001", "password":"123456"}' | jq -r | grep token | awk -F'"' '{print $4}')
	url="https://api51000.jibcom.dev/$api$3"
	if [ $# -ge 3 ]; then
		if [ $# == 3 ]; then
			rm -rf /tmp/api.json && curl -X "$method" "$url" -H "Content-Type: application/json" -H "Authorization: Bearer $token" -v| jq >/tmp/api.json && vim /tmp/api.json
		else
			rm -rf /tmp/api.json && curl -X "$method" "$url" -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d "$4" -v| jq >/tmp/api.json && vim /tmp/api.json
		fi
	fi
}

get_method() {
	if [ "$1" == "post" ] || [ "$1" == "-p" ]; then
		method="POST"
	elif [ "$1" == "get" ] || [ "$1" == "-g" ]; then
		method="GET"
	elif [ "$1" == "push" ] || [ "$1" == "-u" ]; then
		method="PUSH"
	elif [ "$1" == "delete" ] || [ "$1" == "-d" ]; then
		method="DELETE"
	fi
}

get_api() {
	if [ "$1" == "order" ] || [ "$1" == "ord" ]; then
		api="order"
	elif [ "$1" == "internal-login" ] || [ "$1" == "int" ]; then
		api="internal-login"
	elif [ "$1" == "finance" ] || [ "$1" == "fin" ]; then
		api="finance"
	elif [ "$1" == "assembly" ] || [ "$1" == "asm" ]; then
		api="assembly"
	elif [ "$1" == "picking" ] || [ "$1" == "pic" ]; then
		api="picking"
	elif [ "$1" == "stock" ] || [ "$1" == "stc" ]; then
		api="stock"
	elif [ "$1" == "auth" ] || [ "$1" == "aut" ]; then
		api="auth"
	fi
}

main() {
	get_method "$1"
	get_api "$2"
	get "$@"
}

main "$@"

