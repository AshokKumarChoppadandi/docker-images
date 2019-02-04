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
