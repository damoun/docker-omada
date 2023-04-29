#!/bin/sh

OMADA_HOME=/opt/tplink/EAPController/

echo "eap.mongod.uri=${MONGO_URL}" >> "${OMADA_HOME}/properties/omada.properties"
echo "manage.http.port=${OMADA_MANAGE_HTTP_PORT}" >> "${OMADA_HOME}/properties/omada.properties"
echo "manage.https.port=${OMADA_MANAGE_HTTPS_PORT}" >> "${OMADA_HOME}/properties/omada.properties"
echo "portal.http.port=${OMADA_PORTAL_HTTP_PORT}" >> "${OMADA_HOME}/properties/omada.properties"
echo "portal.https.port=${OMADA_PORTAL_HTTPS_PORT}" >> "${OMADA_HOME}/properties/omada.properties"

java \
    -server \
    -Xms128m -Xmx1024m \
    -XX:MaxHeapFreeRatio=60 \
    -XX:MinHeapFreeRatio=30 \
    -XX:+HeapDumpOnOutOfMemoryError \
    -Djava.awt.headless=true \
    -XX:HeapDumpPath=/opt/tplink/EAPController/logs/java_heapdump.hprof \
    -cp "/usr/share/java/commons-daemon.jar:${OMADA_HOME}/dependency/*:${OMADA_HOME}/lib/*:${OMADA_HOME}/properties" \
    com.tplink.smb.omada.starter.OmadaLinuxMain start
