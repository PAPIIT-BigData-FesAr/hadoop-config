#!/bin/bash

# Cargar variables de Hadoop
source /opt/bd/hadoop/etc/hadoop/hadoop-env.sh


# INICIAR SOLO SERVICIOS DE dnnm
HOSTNAME=$(hostname)
HADOOP_HOME=/opt/bd/hadoop/

echo "Iniciando servicios para DNNM: $HOSTNAME"

# INICIAR SOLO DATANODE Y NODEMANAGER
export SPARK_EXECUTOR_HOSTNAME=$(hostname)

echo "Iniciando DataNode..."
$HADOOP_HOME/bin/hdfs --daemon start datanode

echo "Iniciando NodeManager..."
$HADOOP_HOME/bin/yarn --daemon start nodemanager

# Verificar procesos
sleep 5
echo "Procesos Java en ejecución:"
jps

# LOOP DE MONITOREO SIMPLIFICADO para dnnm
while true; do 
    sleep 30
    
    # Verificar DataNode
    if ! jps | grep -q "DataNode"; then
        echo "DataNode no está ejecutándose - reintentando..."
        $HADOOP_HOME/bin/hdfs --daemon start datanode
    fi
    
    # Verificar NodeManager
    if ! jps | grep -q "NodeManager"; then
        echo "NodeManager no está ejecutándose - reintentando..."
        $HADOOP_HOME/bin/yarn --daemon start nodemanager
    fi
done