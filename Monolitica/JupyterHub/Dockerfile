FROM jupyterhub/jupyterhub:latest

# Instalamos el plugin para Docker Swarm
RUN pip install dockerspawner jupyterhub-idle-culler oauthenticator

COPY Config-files/jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py

CMD ["jupyterhub", "--config", "/etc/jupyterhub/jupyterhub_config.py", "--ip=0.0.0.0"]
