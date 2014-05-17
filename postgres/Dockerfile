FROM ubuntu:12.04

ENV USERNAME docker
ENV PASSWORD docker
ENV DB docker
ENV DATA_DIR /data

# Add to be able to download latest 9.3 version
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update
RUN apt-get install -y python-software-properties software-properties-common
RUN apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3
RUN apt-get install -y supervisor
RUN apt-get install -y sudo
RUN apt-get install -y vim

# Allow remote connections to the database.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Cofigure the database to use our data dir.
RUN sed -i -e"s/data_directory =.*$/data_directory = '\\$DATA_DIR'/" /etc/postgresql/9.3/main/postgresql.conf

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/var/log", "/etc/postgresql", "$DATA_DIR"]

ADD ./deploy/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./scripts/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5432

CMD ["/usr/local/bin/start.sh"]
