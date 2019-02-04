if [ ! -d "deps" ]; then
  echo "Downloading Hive-2.3.4...!!!"
  wget http://mirrors.estointernet.in/apache/hive/hive-2.3.4/apache-hive-2.3.4-bin.tar.gz -P deps/
  wget http://central.maven.org/maven2/mysql/mysql-connector-java/8.0.14/mysql-connector-java-8.0.14.jar -P deps/
  mv deps/mysql-connector-java-8.0.14.jar deps/mysql-connector-java.jar
else
  echo "Hive and MySQL connector jar were already downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/hive:latest
