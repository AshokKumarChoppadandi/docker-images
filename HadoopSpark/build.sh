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
