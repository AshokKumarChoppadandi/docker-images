if [ ! -d "deps" ]; then
  mkdir -p deps
  echo "Downloading Java and Scala...!!!"
  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;" "https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.rpm" -P ./deps
  wget https://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz -P ./deps
else
  echo "Java and Scala were downloaded, skipping download...!!!"
fi

docker build . -t ashokkumarchoppadandi/hadoopbaseimage
