#!/bin/bash

# Cargar variables de Hadoop
source /opt/bd/hadoop/etc/hadoop/hadoop-env.sh


# INICIAR SERVICIOS DE ResourceManager
HADOOP_HOME=/opt/bd/hadoop/

echo "Iniciando servicios de ResourceManager..."

# Iniciar ResourceManager
echo "Iniciando ResourceManager..."
$HADOOP_HOME/bin/yarn --daemon start resourcemanager

# Verificar procesos
sleep 5
echo "Procesos Java en ejecución:"
jps

# LOOP DE MONITOREO ESPECÍFICO para ResourceManager
while true; do 
    sleep 30
    
    # Verificar ResourceManager
    if ! jps | grep -q "ResourceManager"; then
        echo "ResourceManager no está ejecutándose - reintentando..."
        $HADOOP_HOME/bin/yarn --daemon start resourcemanager
    fi
done