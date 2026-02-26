# Instalamos una versión actualizada de Ubuntu para asegurarnos de tener las últimas actualizaciones y compatibilidad con Hadoop y Spark.
FROM ubuntu:24.04

LABEL maintainer="https://github.com/PAPIIT-BIG-DATA-FESAG"

# Cambiamos al usuario root
USER root

# Establecemos las variables
ENV HADOOP_VERSION 3.3.6
ENV BASE_DIR /opt/bd
ENV HADOOP_HOME=${BASE_DIR}/hadoop
ENV LOG_TAG "[BASE Hadoop_${HADOOP_VERSION}]:"
ENV REPOSITORY https://dlcdn.apache.org/hadoop/common
ENV SPARK_VERSION=3.5.2
ENV SPARK_HOME=${BASE_DIR}/spark
ENV LOG_TAG="[Hadoop ${HADOOP_VERSION} | Spark ${SPARK_VERSION}]:"
ENV PATH="${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${PATH}"
ENV PYTHONPATH="${SPARK_HOME}/python/:${PYTHONPATH}"

# Instalamos el software necesario para Hadoop y Spark. 
# También instalamos PySpark para poder usar Spark con Python.
RUN echo "$LOG_TAG actualizando e instalando paquetes básicos" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    python3 \
    python3-setuptools \
    curl \
    locales \
    iputils-ping \
    python3-pip && \
    pip3 install --no-cache-dir --break-system-packages \
    pyspark==${SPARK_VERSION} \
    pyarrow \
    pandas \
    numpy \
    openpyxl \
    matplotlib \
    seaborn \
    plotly \
    boto3 \
    requests \
    sqlalchemy \
    psycopg2-binary \
    scikit-learn &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*  

# Configuramos el idioma
RUN echo "$LOG_TAG configurando idioma" && \
    locale-gen es_ES.UTF-8 && update-locale LANG=es_ES.UTF-8

# Creamos una carpeta para la instalación en /opt
RUN mkdir -p ${BASE_DIR}
    
# Creamos una carpeta para la instalación de Apache Spark
RUN mkdir -p ${SPARK_HOME}

# Cambiamos a la carpeta creada
WORKDIR ${BASE_DIR}

# Descargamos y configuramos Hadoop y Spark
RUN echo "${LOG_TAG} Descargando y configurando Hadoop y Spark..." && \
    # Descargar y descomprimir Hadoop
    curl -fLO "https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" && \
    tar xzvf hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} hadoop && \
    rm hadoop-${HADOOP_VERSION}.tar.gz && \
    # Descargar y descomprimir Spark
    curl -fLO "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz" && \
    tar xzvf spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop3 spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Creamos un grupo Hadoop y un usuario hdadmin para ejecutar los diferentes daemon de Hadoop (HDFS y YARN)
# Cambiamos el propietario del directorio de Hadoop 
RUN groupadd -r hadoop && \
    useradd -r -g hadoop -d ${BASE_DIR} -s /bin/bash hdadmin

# Creamos una carpeta para los ficheros de log
RUN mkdir ${HADOOP_HOME}/logs

# Establecemos los permisos
RUN chown -R hdadmin:hadoop ${BASE_DIR}

USER hdadmin

# Exponemos los puertos para Hadoop y Spark
EXPOSE 4040 8888 8080 8081 9870