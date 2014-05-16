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

Haystack setup
--------------
1. Use `manage.py build_solr_schema` to build `schema.xml`
3. Add the following to `schema.xml`::
    ..
    <field name="_version_" type="long" indexed="true" stored ="true"/>
    ..
3. Update the `stopwords_en.txt` path in the `schema.xml` to `lang/stopwords_en.txt` or create an empty file `stopwords_en.txt` in `/my/solr/config/`
4. Copy `schema.xml` to `/my/solr/config/

