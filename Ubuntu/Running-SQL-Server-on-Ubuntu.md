# Running SQL Server 2017 on Ubuntu

### Pull the SQL Server 2017 Docker container from Docker Hub
`docker pull mcr.microsoft.com/mssql/server:2017-latest-ubuntu`

### Create a directory `sqldata` in your home directory to persistenly store database
`mkdir $HOME/sqldata`

### Install the Microsoft ODBC Driver for SQL Server on Linux
Via [https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017](https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017)<br>
```
sudo su 
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

#Download appropriate package for the OS version
#Choose only ONE of the following, corresponding to your OS version

#Ubuntu 14.04
curl https://packages.microsoft.com/config/ubuntu/14.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

#Ubuntu 16.04
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

#Ubuntu 18.04
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

#Ubuntu 18.10
curl https://packages.microsoft.com/config/ubuntu/18.10/prod.list > /etc/apt/sources.list.d/mssql-release.list

exit
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install msodbcsql17
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
sudo apt-get install unixodbc-dev
```

**Note**

* Driver version 17.2 or higher is required for Ubuntu 18.04 support.
* Driver version 17.3 or higher is required for Ubuntu 18.10 support.

### Run container
`docker run --rm -v /home/marcel/sqldata:/var/opt/mssql/data -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu`

### For ODBC support in Python (SQLAlchemy)
Install [pyodbc](https://github.com/mkleehammer/pyodbc) via:
* `conda install pyodbc` or
* `pip install pyodbc`

### Sample code to connect to SQL Server via SQLAlchemy + pyodbc
```
import urllib
import pandas as pd
from sqlalchemy import create_engine

params = urllib.parse.quote_plus("DRIVER={ODBC Driver 17 for SQL Server};"
                                 "SERVER=127.0.0.1;"
                                 "DATABASE=master;"
                                 "Uid=sa;"
                                 "Pwd=yourStrong(!)Password;")
# Connect via sa credentials
conn = create_engine("mssql+pyodbc:///?odbc_connect={}".format(params))
print(conn)

df = pd.read_sql(f"select * from master.sys.sysdatabases", conn)
df.head()
```
Also see: [https://docs.sqlalchemy.org/en/latest/dialects/mssql.html#module-sqlalchemy.dialects.mssql.pyodbc](https://docs.sqlalchemy.org/en/latest/dialects/mssql.html#module-sqlalchemy.dialects.mssql.pyodbc)

### Interesting links
* [Connection modules for Microsoft SQL databases](https://docs.microsoft.com/en-us/sql/connect/sql-connection-libraries?view=sql-server-2017)
* [Python SQL Driver](https://docs.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server?view=sqlallproducts-allversions)
* [Driver history for Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/connect/connect-history?view=sqlallproducts-allversions)
