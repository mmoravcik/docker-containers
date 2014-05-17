=================
Docker-containers
=================

Solr 4
======

Installation
------------
Instal docker and then

    mkdir -p /my/solr/config
    cd solr4
    sudo docker build -t sol4 .
    sudo docker run -ti -p 8983:8983 -v /my/solr/config/:/host/solr_conf solr4

Go to 127.0.0.1:8983/solr to verify the installation

Haystack and solr4 setup
------------------------
1. Use `manage.py build_solr_schema` to build `schema.xml`
3. Add the following to `schema.xml`
    
    ..
    &lt;field name="_version_" type="long" indexed="true" stored ="true"/&gt;
    ..

3. Update the `stopwords_en.txt` path in the `schema.xml` to `lang/stopwords_en.txt` or create an empty file `stopwords_en.txt` in `/my/solr/config/`
4. Copy `schema.xml` to `/my/solr/config/`

PostgreSQL 9.3
==============

Installation
------------
    cd postgres
    sudo docker build -t postgres .
    sudo docker run -ti -p 5431:5432 -v /my/local/data/:/data -v /my/local/log/:/var/log/ postgres

To verify run `psql -h 127.0.0.1 -p 5431 -U docker` on host computer. Password is `docker`

Configuration
-------------
You can specify username, password, database name in the run docker command:
    -e "USERNAME:new_username" -e "PASSWORD=new_password" -e "DB=new_db_name"

Specify the local data storage and logs. These will be then available in your host machine
    -v my/local/storage/:/data -v /my/loca/log/:/var/log/

