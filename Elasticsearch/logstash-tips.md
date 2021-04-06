# MS SQL driver not loading

See [https://github.com/logstash-plugins/logstash-filter-jdbc_static/issues/47](https://github.com/logstash-plugins/logstash-filter-jdbc_static/issues/47)

Quick-fix:
* copy the driver jar file to directory `/usr/share/logstash/logstash-core/lib/jars` (Logstash 7.12.0 apparently needs the `jre11` SQL driver, i.e. `mssql-jdbc-9.2.1.jre11.jar`).
* Delete the `jdbc_driver_library` setting in `logstash.conf` or set to empty string.
