# Usef aliases and shell functions

## Show SSL certificate as text (define function in `.bashrc`)

`function check_cert() { openssl x509 -in "$1" -text -noout; }`

Also see: [https://www.sslshopper.com/article-most-common-openssl-commands.html](https://www.sslshopper.com/article-most-common-openssl-commands.html)

## Show OpenSSL Ellicptic curve private key as text (define function in `.bashrc`)

`function check_ec_privkey() { openssl ec -in "$1" -text -noout; }`

## Show OpenSSL RSA private key as text (define function in `.bashrc`)

`function check_rsa_privkey() { openssl rsa -in "$1" -text -noout; }`
