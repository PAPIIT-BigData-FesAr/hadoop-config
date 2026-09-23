#!/bin/bash

# Cargar variables de Hadoop
source /opt/bd/hadoop/etc/hadoop/hadoop-env.sh

# INICIAR SERVICIOS DE NameNode
HADOOP_HOME=/opt/bd/hadoop/

echo "Iniciando servicios de NameNode..."

if [ ! -d /var/data/hadoop/hdfs/nn/current ] && [ "${HADOOP_FORMAT_ON_START}" = "true" ]; then
    echo "Formateando NameNode por primera vez..."
    $HADOOP_HOME/bin/hdfs namenode -format -force
    if [ $? -eq 0 ]; then
        echo "NameNode formateado exitosamente"
    else
        echo "Error formateando NameNode"
        exit 1
    fi
fi

# Iniciar servicios de NameNode
echo "Iniciando NameNode..."
$HADOOP_HOME/bin/hdfs --daemon start namenode

echo "Iniciando SecondaryNameNode..."
$HADOOP_HOME/bin/hdfs --daemon start secondarynamenode

# Verificar procesos
sleep 10 
echo "Procesos Java en ejecución:"
jps

# LOOP DE MONITOREO ESPECÍFICO para NameNode
while true; do 
    sleep 30
    
    # Verificar NameNode
    if ! jps | grep -q "NameNode"; then
        echo "NameNode no está ejecutándose - reintentando..."
        $HADOOP_HOME/bin/hdfs --daemon start namenode
    fi
    
    # Verificar SecondaryNameNode
    if ! jps | grep -q "SecondaryNameNode"; then
        echo "SecondaryNameNode no está ejecutándose - reintentando..."
        $HADOOP_HOME/bin/hdfs --daemon start secondarynamenode
    fi
    
    # VERIFICAR ESTADO DEL NameNode
    echo "Verificando estado del NameNode..."
    $HADOOP_HOME/bin/hdfs dfsadmin -report 2>/dev/null || echo "NameNode aún no está listo..."
done