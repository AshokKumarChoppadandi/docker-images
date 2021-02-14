docker run -e HOSTNAME=zookeeper -e ZOOKEEPER_HOST=zookeeper --name zookeeper --hostname zookeeper -idt -p 2181:2181 ashokkumarchoppadandi/confluent-kafka-zookeeper:latest sh
