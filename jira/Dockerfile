FROM openjdk:17-bullseye

ARG JIRA_VERSION=9.17.2
ARG JIRA_PRODUCT=jira-software
ARG POSTGRESQL_DRIVER_VERSION=42.7.3
ARG AGENT_VERSION=1.3.3

ENV JIRA_USER=jira \
    JIRA_GROUP=jira \
    JIRA_HOME=/var/jira \
    JIRA_INSTALL=/opt/jira \
    AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar

ENV JAVA_OPTS="-javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"

RUN mkdir -p ${JIRA_INSTALL} ${JIRA_HOME} ${AGENT_PATH} \
&& curl -o /tmp/atlassian.tar.gz https://product-downloads.atlassian.com/software/jira/downloads/atlassian-${JIRA_PRODUCT}-${JIRA_VERSION}.tar.gz -L \
&& tar xzf /tmp/atlassian.tar.gz -C ${JIRA_INSTALL}/ --strip-components 1 \
&& rm -f /tmp/atlassian.tar.gz \
&& curl -o ${JIRA_INSTALL}/lib/postgresql-${POSTGRESQL_DRIVER_VERSION}.jar https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_DRIVER_VERSION}.jar -L \
&& echo "jira.home = ${JIRA_HOME}" > ${JIRA_INSTALL}/atlassian-jira/WEB-INF/classes/jira-application.properties

RUN export CONTAINER_USER=$JIRA_USER \
&& export CONTAINER_GROUP=$JIRA_GROUP \
&& groupadd -r $JIRA_GROUP && useradd -r -g $JIRA_GROUP $JIRA_USER \
&& chown -R $JIRA_USER:$JIRA_GROUP ${JIRA_INSTALL} ${JIRA_HOME} ${AGENT_PATH}

VOLUME $JIRA_HOME
USER $JIRA_USER
WORKDIR $JIRA_INSTALL
EXPOSE 8080

ENTRYPOINT ["/opt/jira/bin/start-jira.sh", "-fg"]