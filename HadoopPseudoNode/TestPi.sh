CONTAINER_NAME=$1
docker exec -it -u hadoop $CONTAINER_NAME yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.6.jar pi 10 10
