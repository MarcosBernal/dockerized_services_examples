#! /bin/bash

FILEPATH=$(realpath $0) # i.e. /tmp/path/foo
FILENAME=$(basename $0) # i.e. foo
BASEPATH=${FILEPATH%%${FILENAME}} # /tmp/path/

cd $BASEPATH

docker build -t postgresqldockerimage -f postgres_with_pgcli.Dockerfile . > /dev/null
docker run -id --rm -p 5432:5432 \
           --name postgresqldocker \
           -e POSTGRES_USER=postgres \
           -e POSTGRES_PASSWORD=password \
           postgresqldockerimage > /dev/null 

sleep 5
docker exec postgresqldocker psql -h localhost -U postgres -f world.sql > /dev/null
docker exec -it postgresqldocker pgcli -h localhost -U postgres
docker stop postgresqldocker > /dev/null

