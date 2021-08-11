# SQL Snippets for backuping up a database to Azure Storage

Also see:
* [https://sqltouch.blogspot.com/2020/08/on-premises-sql-server-database-backup.html](https://sqltouch.blogspot.com/2020/08/on-premises-sql-server-database-backup.html)
* [https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url?view=sql-server-ver15](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url?view=sql-server-ver15)
* [https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url-best-practices-and-troubleshooting?view=sql-server-ver15](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url-best-practices-and-troubleshooting?view=sql-server-ver15)

## Create Credential
```
CREATE CREDENTIAL [https://mystorageacct.blob.core.windows.net/sqlbackups]
WITH IDENTITY='SHARED ACCESS SIGNATURE'  -- this is a mandatory string and should not be changed  
 , SECRET = 'sp=racwdl&st=2021-08-11T07:19:18Z&se=2021-08-12T07:19:18Z&sv=2020-08-04&sr=c&sig=awsD%e2rsNsXdvYK8QCniKB2u%5uaRd3d0BG2AY54BCum%TiOB2%';
```

## Perform database backup
```
BACKUP DATABASE MYDB 
TO URL = 'https://mystorageacct.blob.core.windows.net/sqlbackups/MYDB.bak'  
WITH COMPRESSION, STATS = 5; 
```
