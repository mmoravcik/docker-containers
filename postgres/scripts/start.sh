#!/bin/bash

if [[ ! "$(ls -A $DATA_DIR)" ]]; then
    echo "Initializing PostgreSQL at $DATA_DIR"
    cp -R /var/lib/postgresql/9.3/main/* $DATA_DIR
fi

chown -R postgres $DATA_DIR
chmod -R 700 $DATA_DIR

mkdir -p /var/log/postgresql /var/log/supervisor /etc/postgresql
chown -R /var/lib/postgresql /var/log/postgresql /etc/postgresql

function db_command {
    echo $@ | su postgres sh -c "/usr/lib/postgresql/9.3/bin/postgres --single -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf"
}

if [ $(env | grep USERNAME) ]; then
    echo "Creating user: $USERNAME"
    db_command "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASSWORD';"
fi

if [ $(env | grep DB) ]; then
    echo "Creating database: $DB"
    db_command "CREATE DATABASE $DB OWNER $USERNAME;"
fi

supervisord -n

