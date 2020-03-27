# BUILDING A KAFKA CLUSTER USING DOCKER / DOCKER-COMPOSE

## Components:
---
There are four services, which are running on seperate Docker containers.
 
1. ZOOKEEPER
2. KAFKA BROKER
3. KAFKA CONNECT
4. POSTGRESQL DATABASE

## Steps To Build A Kafka Cluster Using Docker / Docker-Compose
---
Below are the steps to use / build KAFKA CLUSTER (Single Broker).

There are two ways to bring up the cluster using docker-compose.

1. Downloading the built Images that are available on DockerHub (link). Download or create a file docker-compose.yml file with below configuration:

```
version: '3'

networks:
  kafka_cluster:
    driver: bridge

services:
  zookeeper:
    image: ashokkumarchoppadandi/apache-kafka-zookeeper:0.0.1
    networks:
      - kafka_cluster
    ports:
      - "2181:2181"
    hostname: zookeeper
    environment:
      HOSTNAME: zookeeper
      ZOOKEEPER_HOST: zookeeper
      ZOOKEEPER_PORT: 2181
  broker:
    image: ashokkumarchoppadandi/apache-kafka-broker:0.0.1
    networks:
      - kafka_cluster
    depends_on:
      - zookeeper
    hostname: broker
    environment:
      HOSTNAME: broker
      BROKER_ID: 0
      LISTENER_TYPE: PLAINTEXT
      BROKER_HOST: broker
      BROKER_PORT: 9092
      DEFAULT_PARTITIONS: 3
      ZOOKEEPERS_LIST: 'zookeeper:2181'
    ports:
      - "9092:9092"
  connect:
    image: ashokkumarchoppadandi/apache-kafka-connect:0.0.1
    networks:
      - kafka_cluster
    depends_on:
      - zookeeper
      - broker
    hostname: connect
    environment:
      LISTENER_TYPE: PLAINTEXT
      BROKERS_LIST: 'broker:9092'
      CONNECT_HOST: connect
      CONNECT_PORT: 8083
      CONNECT_REST_ADVERTISED_HOST: connect
      CONNECT_REST_ADVERTISED_PORT: 8083
    ports:
      - "8083:8083"
  postgres:
    image: postgres:11
    networks:
      - kafka_cluster
    depends_on:
      - zookeeper
      - broker
      - connect
    hostname: postgres
    restart: always
    environment:
      POSTGRES_DB: testdb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
```
Run the below command to spin up the cluster:

`docker-compose up -d`

2. Building the Images locally

i. Clone or Download the Git Repository

`$ git clone git@github.com:AshokKumarChoppadandi/docker-images.git`

ii. Go to docker-images/KafkaMultiNodeCluster

`$ cd docker-images/KafkaMultiNodeCluster`

iii. Use docker-compose-build.yml to build the Images and to spin up the cluster using below command:

`$ docker-compose -f docker-compose-build.yml up -d `

Note: Only to build the images without running / starting the docker containers use the below command:

`$ docker-compose -f docker-compose-build.yml build`

3. Checking the Status of the containers:

If docker-compose.yml file is used to run the containers, use the below command to get the status of the containers:

`$ docker-compose ps`

If docker-compose-build.yml file is used to run the containers, use the below command to get the status of the containers:

`$ docker-compose -f docker-compose-build.yml ps`

4. Stopping all the Services / Containers:

If docker-compose.yml file is used to run the containers, use the below command to stop:

`$ docker-compose down`

If docker-compose-build.yml file is used to run the containers, use the below command to stop::

`$ docker-compose -f docker-compose-build.yml down`

NOTE: EXAMPLE TO USE THE ABOVE BUILT CLUSTER WILL BE ADDED SOON....

HAPPY CODING...!!!
---

#### Images Links:

1. APACHE-KAFKA-BASE-IMAGE: https://hub.docker.com/r/ashokkumarchoppadandi/apache-kafka-base
2. APACHE-KAFKA-ZOOKEEPER: https://hub.docker.com/r/ashokkumarchoppadandi/apache-kafka-zookeeper
3. APACHE-KAFKA-BROKER: https://hub.docker.com/r/ashokkumarchoppadandi/apache-kafka-broker
4. APACHE-KAFKA-CONNECT: https://hub.docker.com/r/ashokkumarchoppadandi/apache-kafka-connect

