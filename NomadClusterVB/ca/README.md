## Development Certificate Authority

Contains scritps and configs for creating your own CA and issuing self-signed SSL certificates for development purposes. It extends
[this manual](https://jamielinux.com/docs/openssl-certificate-authority/index.html) by additionaly including subjectAltName field into SSL certificates.

## How-To use

 * Generate rootca key and certificate pair:
   ```bash
   ./scripts/root_issue_pair.sh
   ```
 * Generate intermediate key and certificate pair:
   ```bash
   ./scripts/intermediate_issue_pair.sh
   ```
 * Issue x509 certificate signed by intermediate:
   ```bash
   ./scripts/issue_certificate.sh your.dns.name.local
   ```
 * Revoke previously issued certificate:
   ```bash
   ./scripts/revoke_certificate.sh your.dns.name.local
   ```

After issuing certificate you could find the key in `outputs/you.dns.name.local/you.dns.name.local.key` and the certificate chain  `outputs/you.dns.name.local/you.dns.name.local.crt`

For using it in your development environment just add `ca/certs/ca.cert.pem` into trusted on all your development workstations and virtual machines.