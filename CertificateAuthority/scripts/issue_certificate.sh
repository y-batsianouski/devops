#!/bin/bash

export DNS=$1
cd "$( dirname "${BASH_SOURCE[0]}" )/../ca"

# With key password
# openssl genrsa -aes256 -out intermediate/private/$DNS.key.pem 2048 || exit 1
# Without key password
openssl genrsa -out intermediate/private/$DNS.key.pem 2048 || exit 1
chmod 400 intermediate/private/$DNS.key.pem

openssl req -config intermediate/openssl.cnf \
      -subj "/C=BY/ST=Belarus/L=Minsk/O=y-batsianouski/CN=$DNS/emailAddress=yauheni.batsianouski@gmail.com" \
      -key intermediate/private/$DNS.key.pem \
      -new -out intermediate/csr/$DNS.csr.pem  || exit 2

openssl ca \
      -config intermediate/openssl.cnf \
      -extensions server_cert \
      -days 375 \
      -notext \
      -md sha256 \
      -subj "/C=BY/ST=Belarus/L=Minsk/O=y-batsianouski/CN=$DNS/emailAddress=yauheni.batsianouski@gmail.com" \
      -in intermediate/csr/$DNS.csr.pem \
      -out intermediate/certs/$DNS.cert.pem \
      -batch || exit 3

chmod 444 intermediate/certs/$DNS.cert.pem || exit 5

mkdir -p ../outputs/$DNS
cp intermediate/private/$DNS.key.pem ../outputs/$DNS/$DNS.key
chmod 400 ../outputs/$DNS/$DNS.key
cat intermediate/certs/$DNS.cert.pem intermediate/certs/intermediate.cert.chain.pem > ../outputs/$DNS/$DNS.crt || exit 4
