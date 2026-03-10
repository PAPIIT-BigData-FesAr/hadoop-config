# Arquitectura de clúster con Hadoop y Spark para procesamiento de Big Data
***
## Laboratorio de macrodatos del CIMA FES Aragón
***
### Arquitecturas y objetivos
El presente proyecto cuenta con 4 principales arquitecturas, y el objetivo de cada una son los siguientes: 
* **Monolítica (Servidor):** Esta arquitectura está diseñada principalmente para procesar datos masivos, aprovechando por completo el hardware del servidor, aunque se limita a una única conexión para evitar desbordamientos de memoria.
* **Monolítica (ServidorBigData):** Por otra parte, esta arquitectura está pensada para soportar múltiples conexiones simultáneas, principalmente para clases, aunque sacrificando ligeramente el rendimiento para evitar desbordamiento de memoria.
* **Monolítica (PC):** Esta arquitectura está pensada principalmente para pruebas rápidas con datos pequeños, y para que los estudiantes comprendan de manera básica el funcionamiento de Hadoop y Spark
* **Distribuida:** Esta arquitectura usa Docker Swarm para poder distribuir una red de nodos entre varias PCs, aprovechando el poder de cómputo distribuido de Hadoop y Spark.
### Tecnologías usadas
Las presentes arquitecturas usan las siguientes tecnologías para funcionar de manera adecuada y eficiente, así como presentar un entorno de desarrollo cómodo para los usuarios:
* **Docker Swarm:** Es el encargado de crear una red de nodos (Swarm) para permitir que los distintos componentes del clúster interactuen entre sí, sin necesidad de configurar manualmente direcciones IP, además de administrar todo el clúster únicamente desde el nodo manager.
* **JupyterHub:** Proporciona a los usuarios un entorno ágil para poder desarrollar scripts de PySpark mediante notebooks, cada usuario contando con un espacio de trabajo privado a través de un inicio de sesión con correo institucional (aragon.unam.mx).
* **Portainer:** Este es un pequeño servicio que permite monitorear y administrar contenedores Docker mediante interfaz gráfica. 
### Documentación técnica
La documtación técnica completa del presente proyecto se encuentre dentro del mismo repositorio.
### Despliege del clúster
Para iniciar el swarm necesario para desplegar el clúster se ejecuta el siguiente comando:

```docker swarm init --advertise-addr <ip-nodo-manager>```

Si se busca añadir nodos al swarm, para la arquitectura distribuida, se ejecuta el siguiente comando:

```docker swarm join-token worker```

Esto dará de salida un comando con el token que todos los nodos worker deben ejecutar en su terminal.

Ahora, para construir las imágenes, hay que ejecutar los siguientes comandos dentro del directorio de la arquitectura respectiva:

```docker build -t hadoop-base-image <ruta-dockerfile>```

```docker build -t resourcemanager-image <ruta-dockerfile>```

```docker build -t namenode-base-image <ruta-dockerfile>```

```docker build -t dnnm-image <ruta-dockerfile>```

```docker build -t jupyterhub <ruta-dockerfile>```

```docker build -t alumno-spark <ruta-dockerfile>```

Por último para levanta el clúster se ejecuta el comando:

```docker stack deploy -c <ruta-dockercompose> hadoop```
### Despliegue de portainer
Portainer requiere un stack individual para ser ejecutado, para eso  creamos su volúmen y levantamos el stack:

```docker volume create portainer_data```

```docker stack deploy -c <ruta-portainer-agent-stack> portainer```
### Remover clúster
Para remover el clúster es suficiente con ejecutar el siguiente comando:

```docker stack rm hadoop```

Y para que un nodo salga del swarm (mientras no haya algún contenedor en ejecución) se ejecuta el comando:

```docker swarm leave -f```