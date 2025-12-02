#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export HADOOP_CLIENT_OPTS="-Xmx1G"

# --- Configuración de RAM Exclusiva para ResourceManager ---
# 1 GB para el Heap del RM. Suficiente para Single Node.
export YARN_RESOURCEMANAGER_HEAPSIZE=1024

# Directorios
export HADOOP_CONF_DIR=/opt/bd/hadoop/etc/hadoop
export HADOOP_LOG_DIR=/opt/bd/hadoop/logs

# Usuarios
export HDFS_NAMENODE_USER=hdadmin
export HDFS_DATANODE_USER=hdadmin
export HDFS_SECONDARYNAMENODE_USER=hdadmin
export YARN_RESOURCEMANAGER_USER=hdadmin
export YARN_NODEMANAGER_USER=hdadmin

# Opciones JVM (Java 17 Compatible)
export YARN_RESOURCEMANAGER_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED \
--add-opens=java.base/java.lang.reflect=ALL-UNNAMED \
--add-opens=java.base/java.io=ALL-UNNAMED \
--add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED \
-Xms1g -Xmx1g -XX:+UseG1GC"