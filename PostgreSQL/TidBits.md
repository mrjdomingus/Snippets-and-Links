# Various Tidbits

Q. How do I find PostgreSQL's data directory?<br>
A. ```SHOW data_directory;``` (in psql), or ```select setting from pg_settings where name = 'data_directory';```<br>
