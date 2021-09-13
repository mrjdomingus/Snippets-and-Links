# How to set up logging level in Elasticsearch?

There are [three ways](https://www.elastic.co/guide/en/elasticsearch/reference/current/logging.html#configuring-logging-levels) to do it:

A. By updating the cluster settings dynamically (doesn't require any restart):
```
PUT /_cluster/settings
{
  "transient": {
    "logger.org.elasticsearch[.transport]": "TRACE"
  }
}
```
B. By setting the log level directly in elasticsearch.yml (requires restart):

```logger.org.elasticsearch[.transport]: TRACE```<br>
C. By setting the log level directly in log4j2.properties (requires restart):

```logger[.transport].level = trace```
