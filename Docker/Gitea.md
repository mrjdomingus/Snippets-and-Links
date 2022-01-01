# Various Gitea links / snippets
* [Hosting Gitea and Drone with Docker](https://blog.anoff.io/2019-03-24-self-hosted-gitea-drone/)
* [Setting up Gitea in docker with nginx](https://www.moird.com/setting-up-gitea-in-docker-with-nginx.html)
* [High Tea](https://git.habd.as/comfusion/high-tea)
* [Configure Azure Active Directory as Authentication Provider for Gitea](https://blog.anoff.io/2019-03-23-configure-azure-ad-for-gitea/)

## Backup / restore

Also see: [https://docs.gitea.io/en-us/backup-and-restore/](https://docs.gitea.io/en-us/backup-and-restore/)

For the location of `app.ini` check environment variable `GITEA_APP_INI` when using a rootless docker image (probably `/etc/gitea/app.ini`).

In the rootless gitea image the `gitea` executable is probably located in `/usr/local/bin`.

Create dump file from outside container:<br>
```docker exec -u git -it -w /tmp $(docker ps -qf "name=<NAME_OF_DOCKER_CONTAINER>") bash -c '/path/to/executable/gitea dump -c /path/to/app.ini'```<br><br>
This should result in a zip-file named something like `gitea-dump-1641039649.zip` in the container's `/tmp` folder.<br><br>
Copy the zip-file out of the container for safe keeping.

**Backup from within container**<br>

if necessary, switch to the user running Gitea: `su git`.<br> 
Run `./gitea dump -c /path/to/app.ini` in the Gitea installation directory (`/usr/local/bin`). There should be some output similar to the following:
```
2016/12/27 22:32:09 Creating tmp work dir: /tmp/gitea-dump-417443001
2016/12/27 22:32:09 Dumping local repositories.../home/git/gitea-repositories
2016/12/27 22:32:22 Dumping database...
2016/12/27 22:32:22 Packing dump files...
2016/12/27 22:32:34 Removing tmp work dir: /tmp/gitea-dump-417443001
2016/12/27 22:32:34 Finish dumping in file gitea-dump-1482906742.zip
```

**Restore steps**<br>

Copy dump zip file to `/tmp` in container.
```
cd  /tmp
unzip gitea-dump-nnnnnnnnnn.zip
cp app.ini /etc/gitea/app.ini
cp -rf data/* /var/lib/gitea/
mv repos repositories
cp -rf --parents repositories/* /var/lib/gitea/git/
```
