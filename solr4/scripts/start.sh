#!/bin/bash

# Check if host directory is empty, and if not copy config over
[ "$(ls -A /host/solr_conf/)" ] && rsync -avz /host/solr_conf/* /opt/solr/example/solr/collection1/conf/ || echo "Conf dir empty"

supervisord -n -c /etc/supervisord.conf