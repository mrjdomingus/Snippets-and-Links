# Usef aliases and shell functions

## Show SSL certificate as text (define function in `.bashrc`)

`check_cert() { openssl x509 -in "$1" -text -noout; }`
