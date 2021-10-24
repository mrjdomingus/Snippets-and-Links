# Various Gitea links / snippets
* [Hosting Gitea and Drone with Docker](https://blog.anoff.io/2019-03-24-self-hosted-gitea-drone/)
* [Setting up Gitea in docker with nginx](https://www.moird.com/setting-up-gitea-in-docker-with-nginx.html)
* [High Tea](https://git.habd.as/comfusion/high-tea)
* [Configure Azure Active Directory as Authentication Provider for Gitea](https://blog.anoff.io/2019-03-23-configure-azure-ad-for-gitea/)

## Backup / restore

Also see: [https://docs.gitea.io/en-us/backup-and-restore/](https://docs.gitea.io/en-us/backup-and-restore/)

Create dump file from outside container:<br>
```docker exec -u git -it -w /tmp $(docker ps -qf "name=gitea_server_1") bash -c '/app/gitea/gitea dump -c /data/gitea/conf/app.ini'```

**Restore steps**<br>

Copy dump zip file to /tmp in container.
```
cd  /tmp
unzip gitea-dump-nnnnnnnnnn.zip
cp app.ini /etc/gitea/app.ini
cp -rf data/* /var/lib/gitea/
mv repos repositories
cp -rf --parents repositories/* /var/lib/gitea/git/
```
