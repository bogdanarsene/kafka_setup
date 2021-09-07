#!/bin/bash

# Install Zookeeper, Kafka on Kubernetes

KAFKA_VER=2.8.0
KAFKA_NAME=kafka_2.13-$KAFKA_VER

# install JAVA
sudo apt update
sudo apt -y install default-jre
java -version
# Export persistent environment variable
sudo tee -a /etc/profile.d/java_home.sh <<< "export JAVA_HOME=$(readlink -f /usr/bin/java | sed 's/\/bin\/java//g')"
sudo chmod +x /etc/profile.d/java_home.sh
/etc/profile.d/java_home.sh

# get Kafka
wget https://mirror.efect.ro/apache/kafka/$KAFKA_VER/$KAFKA_NAME.tgz
tar -xzf $KAFKA_NAME.tgz
cd $KAFKA_NAME

# start the kafka environment
# Start the ZooKeeper service
# Note: Soon, ZooKeeper will no longer be required by Apache Kafka.
nohup bin/zookeeper-server-start.sh config/zookeeper.properties &
sleep 5
# Start the Kafka broker service
nohup bin/kafka-server-start.sh config/server.properties &
