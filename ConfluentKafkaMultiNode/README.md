# MULTI NODE CONFLUENT KAFKA

## DOWNLOAD

For this example, confluent-5.3.3-2.12.tar.gz is used (We can also use `confluent-community-5.3.3-2.12.tar.gz`) is downloaded from the below link:

[a link](https://www.confluent.io/previous-versions)


## AVAILABLE SERVICES

1. Zookeeper
2. Kafka Server (1 Broker)
3. Schema Registry
4. Kafka Connect

### Docker Compose command to spin up the cluster:

1. Using the images from DockerHub:
```
$ docker-compose up -d
```
2. Building the Images in local and using them
```
$ docker-compose up -f docker-compose-build.yml -d
```

### Docker Compose command to stop the cluster:


```
$ docker-compose down
```

## Kafka Connect - JDBC SOURCE & SINK CONNECTORS FOR POSTGRESQL DATABASE.

### JDBC SOURCE CONNECTOR:

This connector helps Kafka in reading data from POSTGRESQL database into Kafka Topics. Whenever the new record(s) are inserted into POSTGRESQL table, the records are fetched automatically and ingest the records into Kafka Topic.

Below is the JDBC Source Connector config file:

```
{
  "name": "JdbcSourceConnector",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "tasks.max": "1",
    "connection.url": "jdbc:postgresql://postgres:5432/testdb",
    "connection.user": "postgres",
    "connection.password": "postgres",
    "topic.prefix": "my-first-topic-",
    "mode": "incrementing",
    "incrementing.column.name": "eid",
    "tables.whitelist": "employee"
  }
}
```

The below is the CURL command to submit JDBC SOURCE CONNECTOR:

```
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d @JdbcSourceConnector.json http://localhost:8083/connectors
``` 

### JDBC SINK CONNECTOR:

This connector helps Kafka in writing data from Kafka Topics to POSTGRESQL table. Whenever the new record(s) are inserted into Kafka Topic, the records are fetched automatically and ingest the records into POSTGRESQL table.

Below is the JDBC Sink Connector config file:

```
{
  "name": "JdbcSinkConnector",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
    "topics": "my-first-topic-employee",
    "tasks.max": "1",
    "connection.url": "jdbc:postgresql://postgres:5432/testdb",
    "connection.user": "postgres",
    "connection.password": "postgres",
    "auto.create": "true",
    "auto.evolve": "true",
    "dialect.name": "PostgreSqlDatabaseDialect",
    "insert.mode": "insert",
    "table.name.format": "associates",
    "pk.mode": "kafka"
  }
}
```

The below is the CURL command to submit JDBC SINK CONNECTOR:

```
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d @JdbcSinkConnector.json http://localhost:8083/connectors
```


