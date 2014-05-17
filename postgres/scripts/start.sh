#!/bin/bash

mkdir -p /etc/postgresql /var/lib/postgresql /var/log/postgresql /var/log/supervisor
chown -R postgres:postgres /etc/postgresql /var/lib/postgresql /var/log/postgresql

function db_command {
    echo $@ | su postgres sh -c "/usr/lib/postgresql/9.3/bin/postgres --single -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf"
}

db_command "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASSWORD';"
db_command "CREATE DATABASE $DB OWNER $USERNAME;"

supervisord -n

