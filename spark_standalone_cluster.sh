#!/bin/bash

# Starting the services
function upDaemons {
  docker start nodemaster node2 node3 node4
  sleep 5
  echo "Staring Spark Master Node ...!!!"
  docker exec -u hadoop -it nodemaster spark-2.3.2/sbin/start-master.sh
  sleep 5
  echo "Starting Spark Worder Nodes ...!!!"
  docker exec -u hadoop -it node2 spark-2.3.2/sbin/start-slave.sh nodemaster:7077
  docker exec -u hadoop -it node3 spark-2.3.2/sbin/start-slave.sh nodemaster:7077
  docker exec -u hadoop -it node4 spark-2.3.2/sbin/start-slave.sh nodemaster:7077 
  sleep 5

  echo "Spark Master is running @ nodemaster: http://172.18.1.1:8080"
}

if [[ $1 = "start" ]]; then
  echo "Starting the Spark Services...!!!"
  upDaemons
  exit
fi

if [[ $1 = "stop" ]]; then
  echo "Stopping the Spark Services...!!!"
  docker stop nodemaster node2 node3 node4
  exit
fi

if [[ $1 = "deploy" ]]; then
  docker rm -f `docker ps -aq`
  docker network rm hadoop_network
  docker network create --subnet=172.18.0.0/16 hadoop_network

  echo "Deploying Spark Master Node"
  docker run -d --net hadoop_network --ip 172.18.1.1 --hostname nodemaster --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 -p 8080:8080 -p 4040:4040 --name nodemaster -it ashokkumarchoppadandi/standalonespark bash

  echo "Deploying Spark Worker Nodes"
  docker run -d --net hadoop_network --ip 172.18.1.2 --hostname node2  --add-host nodemaster:172.18.1.1 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 --link nodemaster --name node2 -it ashokkumarchoppadandi/standalonespark bash
  docker run -d --net hadoop_network --ip 172.18.1.3 --hostname node3  --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node4:172.18.1.4 --link nodemaster --name node3 -it ashokkumarchoppadandi/standalonespark bash
  docker run -d --net hadoop_network --ip 172.18.1.4 --hostname node4  --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --link nodemaster --name node4 -it ashokkumarchoppadandi/standalonespark bash
  
  upDaemons
  exit
fi

echo "Usage: spark_standalone_cluster.sh deploy|start|stop"
echo "    deploy - Deploy a new cluster"
echo "    start - Start the containers of existing Spark Cluster"
echo "    stop - Stop the Spark Cluster"



