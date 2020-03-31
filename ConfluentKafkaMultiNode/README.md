# MULTI NODE CONFLUENT KAFKA

## DOWNLOAD

For this example, confluent-5.3.3-2.12.tar.gz is used (We can also use `confluent-community-5.3.3-2.12.tar.gz`) is downloaded from the below link:

[a link](https://www.confluent.io/previous-versions)


## AVAILABLE SERVICES

1. Zookeeper
2. Kafka Server (1 Broker)
3. Schema Registry
4. Kafka Connect

Docker Compose command to spin up the cluster:
---
1. Using the images from DockerHub:
```
$ docker-compose up -d
```
2. Building the Images in local and using them
```
$ docker-compose up -f docker-compose-build.yml -d
```


Docker Compose command to stop the cluster:
---

```
$ docker-compose down
```
