import os
from dockerspawner import SwarmSpawner

c = get_config()

# --- Configuración Básica ---
c.JupyterHub.spawner_class = SwarmSpawner
# Forzamos al Hub principal a usar todas las interfaces
c.JupyterHub.hub_ip = '0.0.0.0'
#Definimos el puerto donde el proxy hablará con el Hub
c.JupyterHub.hub_port = 8081
# Le indicamos a los contenedores cómo encontrar al Hub
c.JupyterHub.hub_connect_ip = 'jupyterhub' 
# El proxy escucha al exterior en el 8000
c.JupyterHub.port = 8000
# Obligamos al proxy a escuchar en todas las interfaces para evitar el VIP binding
c.JupyterHub.ip = '0.0.0.0'
# --- Configuración de la Imagen del Alumno ---
c.SwarmSpawner.image = 'alumno-spark:latest' 

# Red: Debe ser la misma que se define en el docker-compose
c.SwarmSpawner.network_name = 'hadoop_hadoop-net'

# --- Inyección de Configuración Hadoop (LA MAGIA) ---
# Esto monta los configs que definiste en el docker-compose DENTRO
# del contenedor del alumno automáticamente.
c.SwarmSpawner.configs = {
    'hadoop_core-site.xml': {'target': '/etc/hadoop/conf/core-site.xml'},
    'hadoop_yarn-site-resourcemanager.xml': {'target': '/etc/hadoop/conf/yarn-site.xml'},
    'hadoop_hdfs-site-namenode.xml': {'target': '/etc/hadoop/conf/hdfs-site.xml'}
}

# --- Variables de Entorno para el Alumno ---
c.SwarmSpawner.environment = {
    'SPARK_MASTER': 'yarn', # Para que use YARN por defecto
    'HADOOP_CONF_DIR': '/etc/hadoop/conf',
    'YARN_CONF_DIR': '/etc/hadoop/conf',
    'JAVA_HOME': '/usr/lib/jvm/java-17-openjdk-amd64'
}

# --- Recursos por Alumno ---
c.SwarmSpawner.mem_limit = '2G' # Límite de RAM para el notebook (Driver)
c.SwarmSpawner.cpu_limit = 1.0

# --- Autenticación (Dummy para pruebas) ---
# Esto permite entrar con cualquier usuario/pass. 
c.JupyterHub.authenticator_class = 'jupyterhub.auth.DummyAuthenticator'

# Borrar contenedores huérfanos
c.SwarmSpawner.remove = True