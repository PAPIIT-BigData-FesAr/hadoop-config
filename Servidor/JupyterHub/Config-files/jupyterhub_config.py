import os
from dockerspawner import SwarmSpawner
from oauthenticator.google import GoogleOAuthenticator

c = get_config()

# --- Configuración Básica de Red (Swarm) ---
c.JupyterHub.spawner_class = SwarmSpawner
c.JupyterHub.hub_ip = '0.0.0.0'
c.JupyterHub.hub_port = 8081
c.JupyterHub.hub_connect_ip = 'jupyterhub' 
c.JupyterHub.port = 8000
c.JupyterHub.ip = '0.0.0.0'

# ==========================================
# --- Autenticación Institucional Google ---
# ==========================================
c.JupyterHub.authenticator_class = GoogleOAuthenticator

# Pega aquí exactamente los ID y secreto que te dio Google
c.GoogleOAuthenticator.client_id = ''
c.GoogleOAuthenticator.client_secret = ''

# IP local del servidor más el servidor DNS nip.io para resolver el dominio dinámicamente
c.GoogleOAuthenticator.oauth_callback_url = 'http://cluster.bigdata.unam.mx:8000/hub/oauth_callback'
# Candados de dominio institucional
c.GoogleOAuthenticator.hosted_domain = ['aragon.unam.mx', 'unam.mx', 'comunidad.unam.mx']
c.GoogleOAuthenticator.allowed_domains = ['aragon.unam.mx', 'unam.mx', 'comunidad.unam.mx']
c.OAuthenticator.allow_all = True

# Usa el correo completo como nombre del contenedor en el clúster
c.GoogleOAuthenticator.username_claim = 'email'
# ==========================================

# --- Configuración de la Imagen del Alumno ---
c.SwarmSpawner.image = 'alumno-spark:latest' 
c.SwarmSpawner.network_name = 'hadoop_hadoop-net'

# --- Inyección de Configuración Hadoop (XMLs) ---
c.SwarmSpawner.configs = {
    'hadoop_core-site-alumno-spark.xml': {'target': '/etc/hadoop/conf/core-site.xml'},
    'hadoop_yarn-site-alumno-spark.xml': {'target': '/etc/hadoop/conf/yarn-site.xml'},
    'hadoop_hdfs-site-alumno-spark.xml': {'target': '/etc/hadoop/conf/hdfs-site.xml'}
}

# --- Variables de Entorno para PySpark ---
c.SwarmSpawner.environment = {
    'SPARK_MASTER': 'yarn', 
    'HADOOP_CONF_DIR': '/etc/hadoop/conf',
    'YARN_CONF_DIR': '/etc/hadoop/conf',
    'JAVA_HOME': '/usr/lib/jvm/java-17-openjdk-amd64'
}

# --- Recursos por Alumno (Driver) ---
c.SwarmSpawner.mem_limit = '2G' 
c.SwarmSpawner.cpu_limit = 1.0

# Borrar contenedores huérfanos al cerrar sesión
c.SwarmSpawner.remove = True
