#!/bin/sh
echo $1
openssl genrsa -out $1.key 2048
openssl req -new -key $1.key -out $1.csr -subj "/CN=$1" -config openssl.cnf
openssl x509 -req -in $1.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $1.crt -days 365 -extensions v3_req -extfile openssl.cnf
rm $1.csr 
openssl verify -verbose -CAfile ca.crt $1.crt
openssl pkcs12 -export -clcerts -in $1.crt -inkey $1.key -out $1.p12 -passout pass:$1

