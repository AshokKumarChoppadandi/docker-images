echo "Testing the Installation by running SparkPi EXAMPLE on Standalone Spark Cluster"
docker exec -u hadoop -it nodemaster spark-submit --master spark://172.18.1.1:7077 --class org.apache.spark.examples.SparkPi /home/hadoop/spark-2.3.2/examples/jars/spark-examples_2.11-2.3.2.jar 10


echo "Testing the Installation by running SparkPi EXAMPLE on Hadoop Spark Cluster"
docker exec -u hadoop -it nodemaster spark-submit --master yarn --class org.apache.spark.examples.SparkPi /home/hadoop/spark-2.3.2/examples/jars/spark-examples_2.11-2.3.2.jar 10
