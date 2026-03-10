#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export HADOOP_CLIENT_OPTS="-Xmx1G"

# --- Configuración de Directorios ---
export HADOOP_CONF_DIR=/opt/bd/hadoop/etc/hadoop
export HADOOP_LOG_DIR=/opt/bd/hadoop/logs

# --- Usuarios ---
export HDFS_NAMENODE_USER=hdadmin
export HDFS_DATANODE_USER=hdadmin
export HDFS_SECONDARYNAMENODE_USER=hdadmin
export YARN_RESOURCEMANAGER_USER=hdadmin
export YARN_NODEMANAGER_USER=hdadmin

# --- AJUSTE DE MEMORIA (SINGLE NODE) ---
# Bajamos de 2GB a 1GB. Es más que suficiente para gestionar metadatos locales.
export HADOOP_NAMENODE_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED -Xms1g -Xmx1g -XX:+UseG1GC -XX:MaxGCPauseMillis=100"

# SecondaryNameNode: Bajamos a 512MB
export HADOOP_SECONDARYNAMENODE_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED -Xms512m -Xmx512m -XX:+UseG1GC -XX:MaxGCPauseMillis=150"