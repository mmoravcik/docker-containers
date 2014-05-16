FROM ubuntu:12.04

ENV USERNAME docker
ENV PASSWORD docker
ENV DB docker

# Add to be able to download latest 9.3 version
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update
RUN apt-get install -y python-software-properties software-properties-common
RUN apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

# Switch to postgres user
USER postgres

RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASSWORD';" &&\
    createdb -O $USERNAME $DB

# Allow remote connections to the database.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

ADD ./scripts/start.sh /usr/local/bin/start.sh
USER root
RUN chmod +x /usr/local/bin/start.sh

USER postgres
CMD ["/usr/local/bin/start.sh"]
