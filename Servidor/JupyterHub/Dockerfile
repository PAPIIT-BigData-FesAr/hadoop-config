# Dockerfile.hub
FROM jupyterhub/jupyterhub:latest

# Instalamos el plugin para Docker Swarm
RUN pip install dockerspawner jupyterhub-idle-culler oauthenticator

# Copiamos la configuración que haremos en el paso 3
COPY Config-files/jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py

CMD ["jupyterhub", "--config", "/etc/jupyterhub/jupyterhub_config.py", "--ip=0.0.0.0"]
