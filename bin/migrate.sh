#!/usr/bin/env bash
cd "${0%/*}"
BASE=..
DATABASES=${BASE}/databases
SQLITE=${DATABASES}/sqlite

#install pgloader ( see https://pgloader.io/ )
#apt install pgloader
pgloader --with "batch rows=10000" --with "batch size=10MB" --with "prefetch rows=50000" $1 postgresql://postgres:changeme@localhost/sequencing