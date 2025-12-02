#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export HADOOP_CLIENT_OPTS="-Xmx1G"

# --- Configuración de RAM para Daemons de GESTIÓN ---
# Mantenemos los demonios con bajo consumo para priorizar las tareas de los alumnos
export HADOOP_HEAPSIZE_MAX=512m

# 512MB para DataNode
export HADOOP_DATANODE_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED -Xms512m -Xmx512m -XX:+UseG1GC"

# 512MB para NodeManager
export YARN_NODEMANAGER_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED -Xms512m -Xmx512m -XX:+UseG1GC"

export HADOOP_CONF_DIR=/opt/bd/hadoop/etc/hadoop

export HDFS_NAMENODE_USER=hdadmin
export HDFS_DATANODE_USER=hdadmin
export HDFS_SECONDARYNAMENODE_USER=hdadmin
export YARN_RESOURCEMANAGER_USER=hdadmin
export YARN_NODEMANAGER_USER=hdadmin