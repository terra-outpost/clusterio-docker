
#!/bin/sh

docker-compose run -e MODE=admin -e ADMIN=$1 master
