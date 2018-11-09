### Apache 2.4 + security2 + dumpio

The purpouse of this container is to show some ways to log request body

### Build
docker build -t <repository>:<tag> .

### Run
docker run --rm --name apache -p 80:80 <repository>:<tag>

### See the logs for mod_security
```
docker exec -it apache /bin/bash
tail -f /var/log/apache2/body-audit.log
```

### See the logs for dumpio
```
docker exec -it apache /bin/bash
tail -f /var/log/apache2/error.log
```
