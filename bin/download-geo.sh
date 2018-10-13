#!/usr/bin/env bash
cd "${0%/*}"
BASE=..
DATABASES=${BASE}/databases
SQLITE=${DATABASES}/sqlite

cd ${SQLITE}
wget https://gbnci-abcc.ncifcrf.gov/geo/GEOmetadb.sqlite.gz
gunzip GEOmetadb.sqlite.gz