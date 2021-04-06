First, see [https://www.elastic.co/guide/en/elasticsearch/reference/master/system-config.html](https://www.elastic.co/guide/en/elasticsearch/reference/master/system-config.html)

# Additions
With regard to locking JVM/ES heap memory, if [http://localhost:9200/_nodes?filter_path=**.mlockall](http://localhost:9200/_nodes?filter_path=**.mlockall) still returns **false** 
then see [https://stackoverflow.com/questions/51382869/unable-to-lock-jvm-memory-error-12-reason-cannot-allocate-memory-elasticsear](https://stackoverflow.com/questions/51382869/unable-to-lock-jvm-memory-error-12-reason-cannot-allocate-memory-elasticsear)

Quick-and-dirty FIX:
```
sudo nano /usr/lib/systemd/system/elasticsearch.service

ADD
[Service]
LimitMEMLOCK=infinity

RUN systemctl daemon-reload 
RUN systemctl restart elasticsearch.service
```

Better solution (not tested):


Modifying systemd unit files directly under `/lib/systemd/system` or `/usr/lib/systemd/system` is not the right way to manage systemd unit files. 
All user custom changes should be made under `/etc/systemd/system`, so you can be sure your changes will stay there, 
after service/software version upgrade, that could override your changes to systemd unit files under `/lib` and `/usr/lib`.

In this specific case you can do the following:

* Create folder `/etc/systemd/system/elasticsearch.service.d`
* Create file `/etc/systemd/system/elasticsearch.service.d/override.conf`

* Add the following lines to the file above:
```
    [Service] 
    LimitMEMLOCK=infinity
```
* Run `systemctl daemon-reload`
* Run `systemctl restart elasticsearch.service`

