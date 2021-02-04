CONTAINER_NAME=$1
docker run -idt --name $CONTAINER_NAME --hostname $CONTAINER_NAME -p 50070:50070 -p 8088:8088 -p 19888:19888 ashokkumarchoppadandi/hadoop:latest sh
