FROM jupyter/pyspark-notebook:latest

USER root

RUN apt-get update && \
    apt-get install -y openjdk-17-jre-headless && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

RUN mkdir -p /etc/hadoop/conf

ENV HADOOP_CONF_DIR=/etc/hadoop/conf
ENV YARN_CONF_DIR=/etc/hadoop/conf

RUN chown -R ${NB_UID}:${NB_GID} /etc/hadoop/conf /usr/local/spark/conf

USER ${NB_UID}

RUN pip install findspark