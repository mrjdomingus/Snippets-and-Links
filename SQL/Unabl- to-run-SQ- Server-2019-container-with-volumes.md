# You get a `ERROR: Setup FAILED copying system data file` error message when trying to run a SQL Sever 2019 container with volumes.

This happens because of lack of permission. On 2019 mssql docker moved from root user images into not-root. This causes a permission issue for Docker sql-server containers with binded volumes and running on a Linux host (=> has no permission to write into binded volume).

There are few solutions to this problem:<br>
### 1 - Run docker as root.

eg. compose:
```
version: '3.6'
services:
  mssql:
    image: mcr.microsoft.com/mssql/server:2019-latest
    user: root
    ports:
      - 1433:1433
    environment:
      - ACCEPT_EULA=Y
      - SA_PASSWORD=BLAH
    volumes:
      - ./data:/var/opt/mssql/data
```
Source: https://github.com/microsoft/mssql-docker/issues/13#issuecomment-641904197<br>
### 2 - Setup proper directory owner (mssql)

Check id for mssql user on docker image, e.g. `sudo docker run -it mcr.microsoft.com/mssql/server:2019-latest id mssql`<br>
gives: `uid=10001(mssql) gid=0(root) groups=0(root)`<br>
Change folder's owner: `sudo chown 10001 VOLUME_DIRECTORY`

Source in Spanish: https://www.eiximenis.dev/posts/2020-06-26-sql-server-docker-no-se-ejecuta-en-root/<br>
### 3 - Give a full access (NOT recommended)

Give full access to db files on host `sudo chmod 777 -R VOLUME_DIRECTORY`

