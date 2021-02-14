docker run -idt -e HOSTNAME=ksql -e BOOTSTRAP_SERVERS=broker:9092 -e SCHEMAREGISTRY_HOST=schemaregistry:8081 -e UI_ENABLED=true --name ksql --hostname ksql --link zookeeper --link broker --link connect --link schemaregistry -p 8088:8088 ashokkumarchoppadandi/confluent-kafka-ksql:latest sh
