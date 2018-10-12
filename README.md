bigdata-docker
==============

Inspired by https://github.com/big-data-europe

Includes several docker stacks to run bigdata analysis


Spark, Zeppeling and Geometa stack
----------------------------------

Getting latest GeometaDB
------------------------

You can download Geometadb sqlite database:
```bash
databases/postgres/download.sh
```
and then install pgloader and run migration script (postgres containers should be already running)
```bash
sudo apt install pgloader
databases/postgres/migrate.sh
```

Running
------

To start the Web-based UI you should:
* download latest GEOMetadb Sqlite from https://gbnci-abcc.ncifcrf.gov/geo/GEOmetadb.sqlite.gz
* add path to it to application.conf
* start the web app by:
```bash
mill web.server.runLocal
```
*open localhost:8080 

