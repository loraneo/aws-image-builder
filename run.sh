#!/bin/bash

apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
apt-get update
apt-get install -y docker-ce
docker swarm init

apt-get install maven

mkdir data
cd data
git clone https://github.com/loraneo/docker-os.git
git clone https://github.com/loraneo/docker-java.git
git clone https://github.com/loraneo/docker-zookeeper.git
git clone https://github.com/loraneo/docker-kafka-broker.git
git clone https://github.com/loraneo/aws-image-builder.git
git clone https://github.com/loraneo/cdr-gen.git
git clone https://pofuk@bitbucket.org/loraneo/cdr-kafka-stream.git

cd docker-os && ./build.sh && cd ..
cd docker-java && chmod +x *.sh -R && ./build.sh && cd ..
cd docker-zookeeper && chmod +x *.sh -R && ./build.sh && cd ..
cd docker-kafka-broker && chmod +x *.sh -R && ./build.sh && cd ..
cd cdr-gen && chmod +x *.sh -R && ./build.sh && cd ..
cd cdr-kafka-stream && chmod +x *.sh -R && ./build.sh && cd ..
