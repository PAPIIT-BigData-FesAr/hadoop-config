# Partimos del contenedor creado anteriormente
FROM hadoop-base-image:latest

MAINTAINER https://www.proyectoa.com

USER root

ENV HADOOP_VERSION 3.3.6
ENV LOG_TAG "[Resourcemanager Hadoop_${HADOOP_VERSION}]:"
ENV BASE_DIR /opt/bd
ENV HADOOP_HOME ${BASE_DIR}/hadoop/
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop/

RUN echo "$LOG_TAG Creando carpetas para logs y temporales" && \
    mkdir -p ${HADOOP_HOME}/logs && \
    mkdir -p /tmp/hadoop-hdadmin && \
    chown -R hdadmin:hadoop ${HADOOP_HOME}/logs && \
    chown -R hdadmin:hadoop /tmp/hadoop-hdadmin

# Copiamos los ficheros de configuración
COPY Config-files/core-site.xml ${HADOOP_CONF_DIR}/core-site.xml
COPY Config-files/yarn-site-resourcemanager.xml ${HADOOP_CONF_DIR}/yarn-site.xml
COPY Config-files/mapred-site-resourcemanager.xml ${HADOOP_CONF_DIR}/mapred-site.xml
COPY Config-files/hadoop-env.sh ${HADOOP_CONF_DIR}/hadoop-env.sh

# Script de inicio
COPY Config-files/start-daemons-resourcemanager.sh ${BASE_DIR}/start-daemons.sh
COPY Config-files/spark-defaults.conf /opt/bd/spark/spark-3.5.0-bin-hadoop3/conf/

# Establecemos los permisos
RUN chmod +x ${BASE_DIR}/start-daemons.sh && \
    chown -R hdadmin:hadoop ${BASE_DIR}

# Puertos
EXPOSE 8030 8031 8032 8033 8088 8090

# Variables de entorno
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64/
ENV HADOOP_HOME ${BASE_DIR}/hadoop/
ENV PATH ${JAVA_HOME}/bin:${PATH}:${HADOOP_HOME}/bin/:${HADOOP_HOME}/sbin/

WORKDIR ${HADOOP_HOME}

CMD ["/opt/bd/start-daemons.sh"]

USER hdadmin