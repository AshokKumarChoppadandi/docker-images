if [ ! -d "deps" ]; then
  mkdir -p deps/
  echo "Downloading Apache Zeppelin - 0.8.1...!!!"
  wget http://mirrors.estointernet.in/apache/zeppelin/zeppelin-0.8.1/zeppelin-0.8.1-bin-all.tgz -P deps/  
else
  echo "Apache Zeppelin is already downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/zeppelin:latest
