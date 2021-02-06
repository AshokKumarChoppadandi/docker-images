CONTAINER_NAME=$1
docker run -idt --name $CONTAINER_NAME --hostname $CONTAINER_NAME -p 50070:50070 -p 8088:8088 -p 19888:19888 -p 8080:8080 -p 4040:4040 ashokkumarchoppadandi/hadoopspark:latest sh
