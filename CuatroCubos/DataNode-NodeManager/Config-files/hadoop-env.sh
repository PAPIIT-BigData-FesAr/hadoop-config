#!/bin/bash

export HADOOP_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED"
# --- Configuración de RAM para Daemons de HDFS ---
# 1 GB para el NameNode
export HADOOP_NAMENODE_HEAPSIZE=1024
# 1 GB para cada DataNode
export HADOOP_DATANODE_HEAPSIZE=1024

# --- Configuración de RAM para Daemons de YARN ---
# 1 GB para el ResourceManager
export YARN_RESOURCEMANAGER_HEAPSIZE=1024
# 1 GB para cada NodeManager
export YARN_NODEMANAGER_HEAPSIZE=1024