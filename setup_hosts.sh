#!/bin/bash

# --- Variables de Configuración ---
IP="192.168.10.200"
DOMAIN="cluster.bigdata.unam.mx"
ALIAS="servidor"
HOSTS_FILE="/etc/hosts"

# 1. Verificar si el script se está ejecutando con permisos de administrador (root)
if [ "$EUID" -ne 0 ]; then
  echo "Error: Necesitas permisos de administrador."
  echo "Por favor, ejecuta el script así: sudo $0"
  exit 1
fi

echo "--- Verificando archivo $HOSTS_FILE ---"

# Se agrega un separador visual si el archivo no tiene nuestras configuraciones aún
if ! grep -q "$IP" "$HOSTS_FILE"; then
    echo "" >> "$HOSTS_FILE"
    echo "# Configuración local para el clúster de Big Data" >> "$HOSTS_FILE"
fi

# 2. Validar y agregar el dominio principal
if grep -q "[[:space:]]$DOMAIN" "$HOSTS_FILE"; then
    echo "✓ El dominio $DOMAIN ya está configurado. No se requieren cambios."
else
    echo "Agregando $DOMAIN apuntando a $IP..."
    echo "$IP $DOMAIN" >> "$HOSTS_FILE"
fi

# 3. Validar y agregar el nombre corto (servidor)
if grep -q "[[:space:]]$ALIAS" "$HOSTS_FILE"; then
    echo "✓ El alias $ALIAS ya está configurado. No se requieren cambios."
else
    echo "Agregando alias $ALIAS apuntando a $IP..."
    echo "$IP $ALIAS" >> "$HOSTS_FILE"
fi

echo "¡Configuración completada exitosamente!"
