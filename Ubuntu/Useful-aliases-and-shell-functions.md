# Useful aliases and shell functions

## Show SSL certificate as text (define function in `.bashrc`)

`function check_cert() { openssl x509 -in "$1" -text -noout; }`

Also see: [https://www.sslshopper.com/article-most-common-openssl-commands.html](https://www.sslshopper.com/article-most-common-openssl-commands.html)

## Show OpenSSL Ellicptic curve private key as text (define function in `.bashrc`)

`function check_ec_privkey() { openssl ec -in "$1" -text -noout; }`

## Show OpenSSL RSA private key as text (define function in `.bashrc`)

`function check_rsa_privkey() { openssl rsa -in "$1" -text -noout; }`

## Start SQL Server docker container
`function start_sql() { docker run --rm -v $HOME/sqldata:/var/opt/mssql/data -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu; }`

## Access Python 3 by default (define in .bashrc or .bash_aliases)
```
alias pip='pip3.x'
alias python='python3.x'
```
or
```
alias pip='pip3'
alias python='python3'
```
or
```
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
```  
