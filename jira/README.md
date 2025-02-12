# Jira

## How to get license
*Exec to the container and run the following command.*

### Get license for Jira
```
java -jar /var/agent/atlassian-agent.jar -d -p jira \
    -m you@gmail.com \
    -n you@gmail.com \
    -o organization \
    -s <jira-server-id-xxxx>
```

### Get license for Jira plugins
```
java -jar /var/agent/atlassian-agent.jar -d \
    -p <product.id.xxxx> \
    -m you@gmail.com \
    -n you@gmail.com \
    -o organization \
    -s <jira-server-id-xxxx>
```
