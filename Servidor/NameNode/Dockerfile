# Trabajamos sobre la imagen creada anteriormente
FROM hadoop-base-image:latest

MAINTAINER https://www.proyectoa.com

USER root

ENV HADOOP_VERSION 3.3.6
ENV LOG_TAG "[NameNode Hadoop_${HADOOP_VERSION}]:"
ENV BASE_DIR /opt/bd
ENV HADOOP_HOME ${BASE_DIR}/hadoop/
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop/
ENV DATA_DIR /var/data/hadoop/hdfs

# CORREGIDO: Variable de formateo (sin espacios)
ENV HADOOP_FORMAT_ON_START=true

# MEJORADO: Crear TODAS las carpetas necesarias
RUN echo "$LOG_TAG Creando carpetas para NameNode" && \
    mkdir -p ${DATA_DIR}/nn && \
    mkdir -p /opt/bd/hadoop/logs && \
    mkdir -p /tmp/hadoop-hdadmin && \
    chown -R hdadmin:hadoop ${DATA_DIR} && \
    chown -R hdadmin:hadoop /opt/bd/hadoop/logs && \
    chown -R hdadmin:hadoop /tmp/hadoop-hdadmin

# Copiamos los ficheros de configuración y script de inicio
COPY Config-files/core-site.xml ${HADOOP_CONF_DIR}/core-site.xml
COPY Config-files/hdfs-site-namenode.xml ${HADOOP_CONF_DIR}/hdfs-site.xml
COPY Config-files/hadoop-env.sh ${HADOOP_CONF_DIR}/hadoop-env.sh
COPY Config-files/start-daemons-namenode.sh ${BASE_DIR}/start-daemons.sh

# Establecemos los permisos
RUN chmod +x ${BASE_DIR}/start-daemons.sh && \
    chown -R hdadmin:hadoop ${BASE_DIR}

EXPOSE 9000 8020 9870 9871

# Permisos del script
RUN chmod +x ${BASE_DIR}/start-daemons.sh && \
    chown -R hdadmin:hadoop ${BASE_DIR}

# Variables de entorno
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64/
ENV HADOOP_HOME ${BASE_DIR}/hadoop/
ENV PATH ${JAVA_HOME}/bin:${PATH}:${HADOOP_HOME}/bin/:${HADOOP_HOME}/sbin/

WORKDIR ${HADOOP_HOME}

CMD ["/opt/bd/start-daemons.sh"]

USER hdadmin