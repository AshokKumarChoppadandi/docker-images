docker run -idt -e BROKER_HOST=broker -e BROKER_PORT=9092 -e CONNECT_HOST=connect -e CONNECT_PORT=8083 -e KAFKA_ADVERTISED_LISTENERS="broker:9092" -e SCHEMA_REGISTRY_URL="http:\/\/schemaregistry:8081" --link broker --link zookeeper --name connect --hostname connect -p 8083:8083 ashokkumarchoppadandi/confluent-kafka-connect:latest sh
