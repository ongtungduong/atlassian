# Confluence

## How to get license
*Exec to the container and run the following command.*

### Get license for confluence
```
java -jar /var/agent/atlassian-agent.jar -d -p conf \
    -m you@gmail.com \
    -n you@gmail.com \
    -o organization \
    -s <confluence-server-id-xxxx>
```

### Get license for confluence plugins
```
java -jar /var/agent/atlassian-agent.jar -d \
    -p <product.id.xxxx> \
    -m you@gmail.com \
    -n you@gmail.com \
    -o organization \
    -s <confluence-server-id-xxxx>
```

