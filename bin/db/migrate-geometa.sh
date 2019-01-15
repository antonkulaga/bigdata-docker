#!/usr/bin/env bash

/data/sources/bigdata-docker/bin/db/pgloader-bundle-3.6.0/bin/pgloader --with "batch rows=5000" --with "batch size=50MB" --with "prefetch rows=50000" $1 postgresql://postgres:changeme@localhost/geometa
