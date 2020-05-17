# docker-images

## Docker images for the DEV environments needed for a Developer.
This repository consists of 5 different flavours of Hadoop Cluster.
1. Hadoop Cluster
2. Hadoop Cluster with Hive Installed
3. Spark Standalone Cluster
4. Hadoop and Spark Cluster with Hive Installed
5. Zeppelin installed on top of Hadoop and Spark Cluster with Hive.

NOTE: HadoopBaseImage is used to build the Hadoop Cluster from a CentOS7 image.

## Steps to build the Docker images and Deploying the cluster

### Building the HadoopBaseImage

Step 1: Clone the Repository:

`$ git clone https://AshokKumarChoppadandi@bitbucket.org/AshokKumarChoppadandi/docker-images.git`

Step 2: Go to **docker-images** directory

`$ cd docker-images`

Step 3: Go to HadoopBaseImage directory

`$ cd HadoopBaseImage`

Step 4: Build HadoopBaseImage by executing the shell script **build.sh**

`$ ./build.sh`

To view the shell script, run the command: `$ cat build.sh`

```
if [ ! -d "deps" ]; then
  mkdir -p deps
  echo "Downloading Java and Scala...!!!"
  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;" "https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.rpm" -P ./deps
  wget https://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz -P ./deps
else
  echo "Java and Scala were downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/baseimage:latest
```

### Building Hadoop Cluster

Step 1: Goto the **../docker-images/Hadoop** directory

`$ cd ../docker-images/Hadoop`

Step 2: Build Hadoop Image from Hadoop Base Image using the script **build.sh**

`$ ./build.sh`

To view the shell script, run the command: `$ cat build.sh`

```
echo "Generating SSH Key...!!!"
echo "Y" | ssh-keygen -t rsa -P '' -f config/id_rsa

if [ ! -d "deps" ]; then
  mkdir -p deps/
  echo "Downloading Hadoop...!!!"
  wget https://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz -P deps/
else
  echo "Hadoop already downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/hadoop:latest
```

To check the images list, run: **$ docker images**

Step 3: To Deploy, Start and Stop the Core Hadoop Cluster (HDFS, YARN, MAP REDUCE HISTORY SERSVER):

```
$ cd ../docker-images

# To deploy the cluster for the first time
$ ./hadoop_cluster.sh deploy

# To stop the running cluster
$ ./hadoop_cluster.sh stop

# To start the existing(stopped) cluster
$ ./hadoop_cluster.sh start
```

### Building Hadoop Cluster with Hive installed

Step 1: Goto the **../docker-images/MySQLMetastore** directory.

`$ cd ../docker-images/MySQLMetastore`

Step 2: Build the MySQL image for Hive Metastore using the shell script **build.sh**

`$ ./build.sh`

To view the shell script, run the command: `$ cat build.sh`

```
$ docker build . -t ashokkumarchoppadandi/mysql
```

Step 3: Goto the **../docker-images/Hive** directory

`$ cd ../docker-images/Hive`

Step 4: Build Hadoop with Hive Image from HadoopImage using the script **build.sh** in folder **../docker-images/Hive**

`$ ./build.sh`

To view the shell script, run the command: `$ cat build.sh`

```
if [ ! -d "deps" ]; then
  echo "Downloading Hive-2.3.4...!!!"
  wget http://mirrors.estointernet.in/apache/hive/hive-2.3.4/apache-hive-2.3.4-bin.tar.gz -P deps/
  wget http://central.maven.org/maven2/mysql/mysql-connector-java/8.0.14/mysql-connector-java-8.0.14.jar -P deps/
  mv deps/mysql-connector-java-8.0.14.jar deps/mysql-connector-java.jar
else
  echo "Hive and MySQL connector jar were already downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/hive:latest
```

To check the images list, run: **$ docker images**

Step 5: To Deploy, Start and Stop the Hadoop Cluster with Hive installed:

```
$ cd ../docker-images

# To deploy the cluster for the first time
$ ./hive_cluster.sh deploy

# To stop the running cluster
$ ./hadoop_cluster.sh stop

# To start the existing(stopped) cluster
$ ./hadoop_cluster.sh start
```

### Building Spark Standalone Spark Cluster

Step 1: Goto **../docker-images/Spark** directory.

`$ cd ../docker-images/Spark`

Step 2: Build the Spark image from HadoopBaseImage using the shell script **build.sh**

`$ ./build.sh`

To view the shell script, run the command: `$ cat build.sh`

```
if [ ! -d "deps" ]; then
  mkdir -p deps
  echo "Downloading Apache Spark 2.3.2...!!!"
  wget http://mirrors.estointernet.in/apache/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz -P deps/
else
  echo "Apache Spark already downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/standalonespark:latest
```

Step 3: To Deploy, Start and Stop Spark Standalone Cluster:

```
$ cd ../docker-images

# To deploy the cluster for the first time
$ ./spark_standalone_cluster.sh deploy

# To stop the running cluster
$ ./spark_standalone_cluster.sh stop

# To start the existing(stopped) cluster
$ ./spark_standalone_cluster.sh start
```

### Building Hadoop and Spark Cluster with Hive installed

Step 1: Goto **../docker-images/HadoopSpark** directory.

`$ cd ../docker-images/HadoopSpark`

Step 2: Build the HadoopSpark image from Hive using the shell script **build.sh**

`$ ./build.sh`

To view the shell script, run the command: `$ cat build.sh`

```
if [ ! -d "deps" ]; then
  mkdir -p deps
  echo "Downloading Apache Spark 2.3.2...!!!"
  wget http://central.maven.org/maven2/mysql/mysql-connector-java/8.0.14/mysql-connector-java-8.0.14.jar -P deps/
  mv deps/mysql-connector-java-8.0.14.jar deps/mysql-connector-java.jar
  wget http://mirrors.estointernet.in/apache/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz -P deps/
else
  echo "Apache Spark already downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/hadoopspark:latest
```

Step 3: To Deploy, Start and Stop Spark Standalone Cluster:

```
$ cd ../docker-images

# To deploy the cluster for the first time
$ ./hadoop_spark_cluster.sh deploy

# To stop the running cluster
$ ./hadoop_spark_cluster.sh stop

# To start the existing(stopped) cluster
$ ./hadoop_spark_cluster.sh start
```

### Building Zeppelin Hadoop Spark Image on top of Hadoop and Spark Cluster

Step 1: Goto **../docker-images/Zeppelin** directory.

`$ cd ../docker-images/Zeppelin`

Step 2: Build the HadoopSpark image from Hive using the shell script **build.sh**

`$ ./build.sh`

To view the shell script, run the command: `$ cat build.sh`

```
if [ ! -d "deps" ]; then
  mkdir -p deps/
  echo "Downloading Apache Zeppelin - 0.8.1...!!!"
  wget http://mirrors.estointernet.in/apache/zeppelin/zeppelin-0.8.1/zeppelin-0.8.1-bin-all.tgz -P deps/  
else
  echo "Apache Zeppelin is already downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/zeppelin:latest

```

Step 3: To Deploy, Start and Stop Spark Standalone Cluster:

```
$ cd ../docker-images

# To deploy the cluster for the first time
$ ./zeppelin_hadoop_spark_cluster.sh deploy

# To stop the running cluster
$ ./zeppelin_hadoop_spark_cluster.sh stop

# To start the existing(stopped) cluster
$ ./zeppelin_hadoop_spark_cluster.sh start
```


The following is the shell scripts used to for creating the containers and running the required services.

1. hadoop_cluster.sh - Core Hadoop Cluster (HDFS, YARN & Map Reduce History Server)
2. hive_cluster - Core Hadoop Cluster (HDFS, YARN & Map Reduce History Server) with Hive installed
3. spark_standalone_cluster.sh - Standalone Spark Cluster without Hadoop
4. hadoop_spark_cluster.sh - Hadoop and Spark Cluster with Hive
5. zeppelin_hadoop_spark_cluster.sh - Hadoop and Spark Cluster with Hive and Zeppelin

**zeppelin_hadoop_spark_cluster.sh**

```
#!/bin/bash

# Starting the services
function upDaemons {
  docker start mysql-metastore nodemaster node2 node3 node4
  sleep 5
  echo "Staring HDFS ...!!!"
  docker exec -u hadoop -it nodemaster start-dfs.sh
  sleep 5
  echo "Starting YARN ...!!!"
  docker exec -u hadoop -it nodemaster start-yarn.sh
  sleep 5
  echo "Starting MAP REDUCE HISTORY SERVER"
  docker exec -u hadoop -it nodemaster mr-jobhistory-daemon.sh start historyserver
  sleep 5
  # Creating default Hive HDFS warehouse directory
  docker exec -u hadoop -it nodemaster hdfs dfs -mkdir -p /tmp
  docker exec -u hadoop -it nodemaster hdfs dfs -mkdir -p /user/hive/warehouse
  docker exec -u hadoop -it nodemaster hdfs dfs -chmod g+w /tmp
  docker exec -u hadoop -it nodemaster hdfs dfs -chmod g+w /user/hive/warehouse
  
  # Setting Hive Metastore to MYSQL database
  docker exec -u hadoop -it nodemaster schematool -dbType mysql -initSchema
  
  # Starting the Spark Master and Worker Daemons
  docker exec -u hadoop -it nodemaster spark-2.3.2/sbin/start-master.sh
  docker exec -u hadoop -it node2 spark-2.3.2/sbin/start-slave.sh nodemaster:7077
  docker exec -u hadoop -it node3 spark-2.3.2/sbin/start-slave.sh nodemaster:7077
  docker exec -u hadoop -it node4 spark-2.3.2/sbin/start-slave.sh nodemaster:7077
  
  # Starting the Zeppelin Daemon
  docker exec -u hadoop -it nodemaster zeppelin-daemon.sh start
  
  echo "Namenode is running @ nodemaster: http://172.18.1.1:50070"
  echo "Resource Manager is running @ nodemaster: http://172.18.1.1:8088"
  echo "Mapreduce History Server is running @ nodemaster: http://172.18.1.1:19888"
  echo "Hive Server2 is running @ nodemaster: http://172.18.1.1:10000"
  echo "Spark Master is running @ nodemaster: http://172.18.1.1:8080"
  echo "Zeppelin is running @ nodemaster: http://172.18.1.1:9090"
}

if [[ $1 = "start" ]]; then
  echo "Starting Hadoop & Spark Services with Zeppelin...!!!"
  upDaemons
  exit
fi

if [[ $1 = "stop" ]]; then
  echo "Stopping the Hadoop, Spark and Zeppelin Services...!!!"
  docker stop nodemaster node2 node3 node4 mysql-metastore
  exit
fi

if [[ $1 = "deploy" ]]; then
  docker rm -f `docker ps -aq`
  docker network rm hadoop_network
  docker network create --subnet=172.18.0.0/16 hadoop_network

  echo "Deploying MySQL database as Hive Metastore"
  docker run  -d --net hadoop_network --ip 172.18.1.11 --hostname mysql-metastore -p 3306:3306 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 --name mysql-metastore -e MYSQL_ROOT_PASSWORD=123456 ashokkumarchoppadandi/mysql
  
  echo "Deploying Hadoop & Spark Master Node with Zeppelin"
  docker run -d --net hadoop_network --ip 172.18.1.1 --hostname nodemaster --add-host mysql-metastore:172.18.1.11 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 -p 50070:50070 -p 8032:8032 -p 8020:8020 -p 50030:50030 -p 19888:19888 -p 8088:8088 -p 8080:8080 -p 4040:4040 -p 9090:9090 --mount "src=/home/vagrant/ZeppelinNotebooks/,target=/home/hadoop/zeppelin-0.8.1/notebook/,type=bind" --link mysql-metastore --name nodemaster -it ashokkumarchoppadandi/zeppelin bash

  echo "Deploying Hadoop & Spark Worker Nodes"
  docker run -d --net hadoop_network --ip 172.18.1.2 --hostname node2 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 --link nodemaster --link mysql-metastore --name node2 -it ashokkumarchoppadandi/zeppelin bash
  docker run -d --net hadoop_network --ip 172.18.1.3 --hostname node3 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node4:172.18.1.4 --link nodemaster --link mysql-metastore --name node3 -it ashokkumarchoppadandi/zeppelin bash
  docker run -d --net hadoop_network --ip 172.18.1.4 --hostname node4 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --link nodemaster --link mysql-metastore --name node4 -it ashokkumarchoppadandi/zeppelin bash
  
  echo "Formatting Namenode on Hadoop Master Node...!!!"
  docker exec -u hadoop -it nodemaster hdfs namenode -format

  echo "Starting Hadoop & Spark Daemons...!!!"
  upDaemons
  exit
fi


echo "Usage: hadoop_spark_cluster.sh deploy|start|stop"
echo "    deploy - Deploy a new cluster"
echo "    start - Start the containers of existing Hadoop & Spark Cluster"
echo "    stop - Stop Hadoop & Spark Cluster"
```

NOTE: These shell script will deploy 3 node clusters.
