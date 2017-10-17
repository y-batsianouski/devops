#!/bin/bash
cd "$( dirname "${BASH_SOURCE[0]}" )/../ca"

# Just for avoid openssl.cnf error
export DNS=intermediate


mkdir -p intermediate/certs intermediate/crl intermediate/csr intermediate/newcerts intermediate/private
chmod 700 intermediate/private
touch intermediate/index.txt
echo 1000 > intermediate/serial

# Generate intermediate key

# With key password
# openssl genrsa -aes256 -out intermediate/private/intermediate.key.pem 4096
# Without key password
openssl genrsa -out intermediate/private/intermediate.key.pem 4096
chmod 400 intermediate/private/intermediate.key.pem

# Generate intermediate CSR
openssl req -config intermediate/openssl.cnf -new -sha256 \
      -key intermediate/private/intermediate.key.pem \
      -out intermediate/csr/intermediate.csr.pem

# Generate intermediate cert
openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
      -days 3650 -notext -md sha256 \
      -in intermediate/csr/intermediate.csr.pem \
      -out intermediate/certs/intermediate.cert.pem

chmod 444 intermediate/certs/intermediate.cert.pem

# Create certificate chain
cat intermediate/certs/intermediate.cert.pem \
      certs/ca.cert.pem > intermediate/certs/intermediate.cert.chain.pem

chmod 444 intermediate/certs/intermediate.cert.chain.pem