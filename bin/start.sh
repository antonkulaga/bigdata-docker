#!/usr/bin/env bash
cd "${0%/*}"
BASE=..
docker stack deploy -c ${BASE}/bigdata.yml bigdata