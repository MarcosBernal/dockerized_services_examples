FROM postgres:10.6-alpine

RUN apk update \
    && apk add --virtual build-deps gcc python-dev musl-dev \
    && apk add --virtual postgresql-devadd py-pip \
    && pip install psycopg2 pgcli 

RUN SQL_SAMPLE_FILE=/tmp/world.sql.tar \
    && wget -qO - http://pgfoundry.org/frs/download.php/527/world-1.0.tar.gz | gzip -dc > ${SQL_SAMPLE_FILE} \
    && tar -xvf ${SQL_SAMPLE_FILE} && mv dbsamples-0.1/world/world.sql . && rm -r dbsamples-0.1/ && rm ${SQL_SAMPLE_FILE}

