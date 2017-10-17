#!/bin/bash

export DNS=$1
cd "$( dirname "${BASH_SOURCE[0]}" )/../ca"

openssl ca -config intermediate/openssl.cnf -revoke intermediate/certs/$DNS.cert.pem && \
rm -rf ../outputs/$DNS
chmod 700 intermediate/csr/$DNS.csr.pem && rm -rf intermediate/csr/$DNS.csr.pem
chmod 700 intermediate/certs/$DNS.cert.pem && rm -rf intermediate/certs/$DNS.cert.pem
chmod 700 intermediate/private/$DNS.key.pem && rm -rf intermediate/private/$DNS.key.pem