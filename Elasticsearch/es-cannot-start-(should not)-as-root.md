First see, [https://stackoverflow.com/questions/48380051/why-is-elasticsearch-starting-manually-but-not-starting-as-a-service-on-ubuntu-1/48390311#48390311](https://stackoverflow.com/questions/48380051/why-is-elasticsearch-starting-manually-but-not-starting-as-a-service-on-ubuntu-1/48390311#48390311).

Quick rundown how to run es as non-root:<br>
1. Set `START_DAEMON=true` in `/etc/default/elasticsearch` and restart service.
2. If the system has 2GB of RAM (true in my case), set `ES_HEAP_SIZE=1g`.
3. Check the permissions of the elasticsearch directory in `/usr/share/elasticsearch`. Chances are that root owns these, which is not ideal. If you don't know already, running any service as root exposes your infrastructure to exploitation by attackers.
4. The temptation in #3 is to set `ES_USER=root` and `ES_GROUP=root` which will solve your problem. Elasticsearch will start as a service (even though their product documentation alleges that ES won't operate as root). **DON'T DO THAT**.

5. Instead, check that the `elasticsearch` user exists locally and that the group of the same name exists too.
```
$ cut -d: -f1 /etc/passwd
$ cut -d: -f1 /etc/group
```
6. Then, change ownership of all elasticsearch folders and resources to the `elasticsearch` user and group.

```
$ ~ $ > ll /usr/share/elasticsearch/
total 8.0K
drwxr-xr-x 2 elasticsearch 4.0K Jan 22 10:02 bin/
lrwxrwxrwx 1 elasticsearch   18 Dec 24  2015 config -> /etc/elasticsearch/
lrwxrwxrwx 1 elasticsearch   22 Dec 24  2015 data -> /var/lib/elasticsearch/
lrwxrwxrwx 1 elasticsearch   22 Dec 24  2015 logs -> /var/log/elasticsearch/
drwxr-xr-x 2 elasticsearch 4.0K Dec 24  2015 plugins/

# ^-- Take note that the symlinked directories need to be adjusted too

$ sudo chown -R elasticsearch:elasticsearch /usr/share/elasticsearch
$ sudo chown -R elasticsearch:elasticsearch /etc/elasticsearch/
$ sudo chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/
$ sudo chown -R elasticsearch:elasticsearch /var/log/elasticsearch/
```

7. Then, set the values `ES_USER=elasticsearch` and `ES_GROUP=elasticsearch` in `/etc/default/elasticsearch` if they aren't set that way already (in case you gave in to temptation per #4).

8. Restart the elasticsearch service:
```
sudo systemctl restart elasticsearch.service
```
