# Dockerfile.alumno
FROM jupyter/pyspark-notebook:latest

USER root

# 1. Instalamos Java 17 (Crucial para compatibilidad con tu clúster)
# La imagen base suele traer Java 11. Necesitamos forzar la 17.
RUN apt-get update && \
    apt-get install -y openjdk-17-jre-headless && \
    apt-get clean

# 2. Configuramos JAVA_HOME apuntando a la 17
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# 3. Creamos directorios para las configs de Hadoop
RUN mkdir -p /etc/hadoop/conf

# 4. Variables de entorno para que Spark encuentre las configs
ENV HADOOP_CONF_DIR=/etc/hadoop/conf
ENV YARN_CONF_DIR=/etc/hadoop/conf

# Regresamos al usuario normal (jovyan)
USER ${NB_UID}

# 5. Instalamos findspark para facilitar la vida a los alumnos
RUN pip install findspark