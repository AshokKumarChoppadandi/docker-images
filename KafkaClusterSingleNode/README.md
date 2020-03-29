Docker run command:

docker run -idt --name broker --rm -p 2181:2181 -p 9092:9092 -p 8083:8083 --name test -e HOSTNAME=myhost -e ZOOKEEPER_HOST=myhost -e BROKER_HOST=myhost -e ZOOKEEPERS_LIST=myhost:2181 -e BROKERS_LIST=myhost:9092 -e CONNECT_HOST=myhost -e CONNECT_REST_ADVERTISED_HOST=myhost --hostname myhost ashokkumarchoppadandi/apache-kafka:0.0.1 sh


