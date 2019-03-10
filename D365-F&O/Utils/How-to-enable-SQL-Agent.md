# SQL script to enable SQL Server Agent

To see the state of "Agent XPs" option, run the folowing code:

```
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'Agent XPs'
```

To enable the SQL Server Agent extended stored procedures:

```
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'Agent XPs', 1
GO
RECONFIGURE
GO
```
