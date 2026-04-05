FROM hadoop-base-image:latest

USER root

ENV HADOOP_VERSION 3.3.6
ENV LOG_TAG "[DNNM Hadoop_${HADOOP_VERSION}]:"
ENV BASE_DIR /opt/bd
ENV HADOOP_HOME ${BASE_DIR}/hadoop/
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop/
ENV DATA_DIR /var/data/hadoop/hdfs

# Crear TODAS las carpetas necesarias
RUN echo "$LOG_TAG Creando carpetas para datos y logs" && \
    mkdir -p ${DATA_DIR}/dn && \
    mkdir -p /var/data/hadoop/yarn/nm-local && \
    mkdir -p /var/data/hadoop/yarn/nm-logs && \
    mkdir -p /opt/bd/hadoop/logs && \
    mkdir -p /tmp/hadoop-hdadmin && \
    chown -R hdadmin:hadoop ${DATA_DIR} && \
    chown -R hdadmin:hadoop /var/data/hadoop/yarn && \
    chown -R hdadmin:hadoop /opt/bd/hadoop/logs && \
    chown -R hdadmin:hadoop /tmp/hadoop-hdadmin

COPY Config-files/start-daemons.sh ${BASE_DIR}/start-daemons.sh

# Permisos del script
RUN chmod +x ${BASE_DIR}/start-daemons.sh && \
    chown -R hdadmin:hadoop ${BASE_DIR}

# Puertos
EXPOSE 9864 9865 8042

# Variables de entorno
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64/
ENV HADOOP_HOME ${BASE_DIR}/hadoop/
ENV PATH ${JAVA_HOME}/bin:${PATH}:${HADOOP_HOME}/bin/:${HADOOP_HOME}/sbin/
ENV SPARK_EXECUTOR_HOSTNAME=dnnm

WORKDIR ${HADOOP_HOME}

CMD ["/opt/bd/start-daemons.sh"]

USER hdadmin