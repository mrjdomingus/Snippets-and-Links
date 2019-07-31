# Truncate Table
```python
import pandas as pd
from sqlalchemy import create_engine
import urllib

params = urllib.parse.quote_plus("DRIVER={SQL Server Native Client 11.0};"
                                 "SERVER=localhost;"
                                 "DATABASE=mydb;"
                                 "Trusted_Connection=yes")

# Connect via current Windows credentials
conn = create_engine("mssql+pyodbc:///?odbc_connect={}".format(params))

table_name = "XYZ"
conn.execution_options(autocommit=True).execute(f"TRUNCATE TABLE {table_name}")
```
