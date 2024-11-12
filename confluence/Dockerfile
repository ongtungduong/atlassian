FROM openjdk:17-bullseye

ARG ATLASSIAN_PRODUCTION=confluence
ARG APP_NAME=confluence
ARG APP_VERSION=8.9.6
ARG POSTGRESQL_DRIVER_VERSION=42.7.3

ENV CONFLUENCE_USER=confluence \
    CONFLUENCE_GROUP=confluence \
    CONFLUENCE_HOME=/var/confluence \
    CONFLUENCE_INSTALL=/opt/confluence \
    AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar \
    LIB_PATH=/confluence/WEB-INF/lib

ENV JAVA_OPTS="-javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"

RUN mkdir -p ${CONFLUENCE_INSTALL} ${CONFLUENCE_HOME} ${AGENT_PATH} ${CONFLUENCE_INSTALL}${LIB_PATH} \
&& curl -o /tmp/atlassian.tar.gz https://product-downloads.atlassian.com/software/confluence/downloads/atlassian-${APP_NAME}-${APP_VERSION}.tar.gz -L \
&& tar xzf /tmp/atlassian.tar.gz -C /opt/confluence/ --strip-components 1 \
&& rm -f /tmp/atlassian.tar.gz \
&& curl -o ${CONFLUENCE_INSTALL}/lib/postgresql-${POSTGRESQL_DRIVER_VERSION}.jar https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_DRIVER_VERSION}.jar -L \
&& cp ${CONFLUENCE_INSTALL}/lib/postgresql-${POSTGRESQL_DRIVER_VERSION}.jar ${CONFLUENCE_INSTALL}${LIB_PATH}/postgresql-${POSTGRESQL_DRIVER_VERSION}.jar \
&& echo "confluence.home = ${CONFLUENCE_HOME}" > ${CONFLUENCE_INSTALL}/${ATLASSIAN_PRODUCTION}/WEB-INF/classes/confluence-init.properties

RUN export CONTAINER_USER=$CONFLUENCE_USER \
&& export CONTAINER_GROUP=$CONFLUENCE_GROUP \
&& groupadd -r $CONFLUENCE_GROUP && useradd -r -g $CONFLUENCE_GROUP $CONFLUENCE_USER \
&& chown -R $CONFLUENCE_USER:$CONFLUENCE_GROUP ${CONFLUENCE_INSTALL} ${CONFLUENCE_HOME} ${AGENT_PATH}

VOLUME $CONFLUENCE_HOME
USER $CONFLUENCE_USER
WORKDIR $CONFLUENCE_INSTALL
EXPOSE 8090

ENTRYPOINT ["/opt/confluence/bin/start-confluence.sh", "-fg"]