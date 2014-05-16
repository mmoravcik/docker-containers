FROM        ubuntu:12.04
MAINTAINER  Matus Moravcik <matus.moravcik@gmail.com>

ENV SOLR_VERSION 4.8.0
ENV SOLR solr-$SOLR_VERSION

RUN apt-get update
RUN apt-get install -y rsync
RUN apt-get install -y vim
RUN apt-get install -y supervisor
RUN apt-get install -y openjdk-7-jre-headless tar

RUN mkdir -p /opt
ADD http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz /opt/solr-$SOLR_VERSION.tgz
RUN tar -C /opt --extract --file /opt/solr-$SOLR_VERSION.tgz
RUN mv /opt/solr-$SOLR_VERSION /opt/solr

# Use this with `sudo docker run -ti -p 8983:8983 -v /my_solr_conf/:/host/solr_conf docker-solr4` option to specify your config
ADD ./conf/solr /host/solr_conf

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

ADD ./deploy/supervisord.conf /etc/supervisord.conf

EXPOSE 8983

CMD ["/root/start.sh"]
