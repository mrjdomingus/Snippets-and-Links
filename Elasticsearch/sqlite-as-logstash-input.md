This Step-by-Step guide assumes you are using a Logstash container downloaded from [https://www.docker.elastic.co/r/logstash/logstash](https://www.docker.elastic.co/r/logstash/logstash).

# Download SQLite JDBC driver

You can download the latest version of a JDBC driver for SQLite: [https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/)

Place the `sqlite-jdbc-VERSION.jar` into the Java classpath in the logstash container (actually anywhere will do as long as you reference the correct location in the `logstash.conf` file).

# Index setup

Before loading data, we need to setup indices and mappings; for example, let’s create an index called `company-minimal` in the Elasticsearch cluster at http://localhost:9200.

Create the index by running the following command in a terminal window:<br>
`curl -X PUT http://localhost:9200/company-minimal`

If curl is not available on your system, download it from http://curl.haxx.se/download.html .

If the index is created correctly, Elasticsearch will return the following response:<br>
`{"acknowledged":true}`

If you want to destroy the index and start from scratch, execute the following command:<br>
`curl -X DELETE http://localhost:9200/company-minimal`

# Mapping definition
Mappings allow the user to configure how documents are stored in the index. For example, they allow you to define how fields are matched by the search engine and set their type (string, dates, numbers, locations and so on).<br>
For detailed documentation about indices and mappings, read the [Elasticsearch Reference](https://www.elastic.co/guide/en/elasticsearch/reference/index.html).

Let’s define a simple mapping to describe a company. The mapping will define the following fields:
* `id`: the id of the company in the SQLite database
* `name`: the name of the company
* `description`: a description of the company
* `homepage`: the URL of the company homepage
* `number_of_employees`: the number of employees
* `location`: the geographical coordinates of the company

Open a text editor and paste the following text:
```
{
    "CompanyMinimal": {
        "properties": {
            "id": {
                "type": "keyword"
            },
            "number_of_employees": {
                "type": "long"
            },
            "name": {
                "type": "text"
            },
            "description": {
                "type": "text"
            },
            "homepage": {
                "type": "keyword"
            },
            "location": {
                "type": "geo_point"
            }
        }
    }
}
```

`CompanyMinimal` is the name of the mapping; `properties` contains the options for each field.

Save the file to `CompanyMinimal.mapping` inside the folder containing the `logstash.conf` file.

To apply the mapping, execute the following command:<br>
`curl -X PUT "http://localhost:9200/company-minimal/_mapping/CompanyMinimal" -d "@CompanyMinimal.mapping"`

If the mapping is created correctly, Elasticsearch will return the following response:<br>
`{"acknowledged":true}`

# SQL query definition

To extract the values that will be loaded to the index by Logstash, we need to write a SQL query. Open a text editor and paste the following one:
```
SELECT id,
  label AS name,
  description,
  homepage_url as homepage,
  number_of_employees,
  CASE WHEN lat IS NULL THEN
    NULL
  ELSE
    lat || ', ' || lng
  END AS location
  FROM company
  LEFT JOIN company_geolocation ON company.id = company_geolocation.companyid
```

Save the file to `company-minimal.sql` inside the folder containing the `logstash.conf` file.

# Logstash configuration

We now need to write a Logstash configuration to process the records returned by the query and populate the `company-minimal` index.
Support for SQL databases is provided by the [Logstash jdbc input plugin](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html).

Open a text editor and paste the following:<br>
```nput {
  jdbc {
    jdbc_driver_library => "sqlitejdbc-v056.jar"
    jdbc_driver_class => "org.sqlite.JDBC"
    jdbc_connection_string => "jdbc:sqlite:crunchbase.db"
    jdbc_user => ""
    jdbc_password => ""
    statement_filepath => "company-minimal.sql"
    jdbc_paging_enabled => true
    jdbc_page_size => 10000
  }
}

filter {
  mutate {
    remove_field => ["@timestamp", "@version"]
  }
}

output {
  elasticsearch {
    hosts => "localhost:9200"
    manage_template => false
    action => "index"
    index => "company-minimal"
    document_type => "CompanyMinimal"
  }
}
```

The `statement_filepath` parameter specifies the path to the file containing the SQL query; the `jdbc_*` parameters set the database connection string and authentication options.

The `mutate` filter is configured to remove default Logstash fields which are not needed in the destination index.

The `output` section specifies the destination index; `manage_template` is set to `false` as the index mapping has been explicitly defined in the previous steps.

Save the file to `company-minimal.conf` in the logstash configuration folder.

Copy the SQLite database `crunchbase.db` to the logstash configuration folder and run the following command:<br>
`logstash/bin/logstash -f company-minimal.conf`

Logstash will execute the query and populate the index.

# Searching the index

To retrieve all documents in the newly created index execute the following HTTP request using Kibana Dev Tools or Postman:<br>
```
GET localhost:9200/company-minimal/_search
{
    "query": {
        "match_all": {}
    }
}
```

Also see:
* Github repo for the Xerial SQLite JDBC Driver: [https://github.com/xerial/sqlite-jdbc](https://github.com/xerial/sqlite-jdbc)
* [Import data from a SQL database using Logstash](https://docs.siren.io/10.0.2/platform/en/loading-data-into-elasticsearch/from-a-sql-database-using-logstash.html)
