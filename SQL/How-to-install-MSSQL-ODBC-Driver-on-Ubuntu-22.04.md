## First install the essentials
Install build essentials
```
sudo apt update
sudo apt install build-essential manpages-dev
```
Install unixODBC development headers
```
sudo apt-get install -y unixodbc-dev
```

## Warning, this is a temporary fix for as long MS does not support the MSSQL ODBC driver on 22.04

Also see: [https://askubuntu.com/questions/1407533/microsoft-odbc-v18-is-not-find-by-apt](https://askubuntu.com/questions/1407533/microsoft-odbc-v18-is-not-find-by-apt)

Following the next step to install the Ubuntu 21.10 MS SQL ODBC Driver v18 on Ubuntu 22.04:
```
sudo apt-get install odbcinst

sudo curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/21.10/prod impish main" | sudo tee /etc/apt/sources.list.d/mssql-release.list

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18

# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc
```

## For use in Python, install pyodbc
```
pip install pyodbc
```
