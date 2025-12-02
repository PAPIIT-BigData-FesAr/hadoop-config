#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export HADOOP_CLIENT_OPTS="-Xmx1G"

# --- Configuración de RAM Exclusiva para ResourceManager ---
# 2 GB para el Heap de Java del RM.
# El contenedor tiene 4GB, así que sobran 2GB para el SO Ubuntu.
export YARN_RESOURCEMANAGER_HEAPSIZE=2048

# Directorios
export HADOOP_CONF_DIR=/opt/bd/hadoop/etc/hadoop
export HADOOP_LOG_DIR=/opt/bd/hadoop/logs

# Usuarios
export HDFS_NAMENODE_USER=hdadmin
export HDFS_DATANODE_USER=hdadmin
export HDFS_SECONDARYNAMENODE_USER=hdadmin
export YARN_RESOURCEMANAGER_USER=hdadmin
export YARN_NODEMANAGER_USER=hdadmin

# Opciones de la JVM optimizadas
export YARN_RESOURCEMANAGER_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED -Xms2g -Xmx2g -XX:ParallelGCThreads=4 -XX:ConcGCThreads=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=200"