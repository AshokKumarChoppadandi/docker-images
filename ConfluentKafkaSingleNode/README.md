# ONE NODE CONFLUENT KAFKA

## DOWNLOAD

For this example, confluent-5.3.3-2.12.tar.gz is used (We can also use `confluent-community-5.3.3-2.12.tar.gz`) is downloaded from the below link:

[a link](https://www.confluent.io/previous-versions)


## AVAILABLE SERVICES

1. Zookeeper
2. Kafka Server (1 Broker)
3. Schema Registry
4. Kafka Connect

Docker run command:
---
```
$ docker run -idt --name kafka_cluster --hostname myhost --env-file ./env_file -p 2181:2181 -p 9092:9092 -p 8083:8083 -p 8081:8081 --rm ashokkumarchoppadandi/confluent-kafka:0.0.1 sh
```

Docker stop command:
---

```
$ docker stop kafka_cluster
```
