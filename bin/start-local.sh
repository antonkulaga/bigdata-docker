#!/usr/bin/env bash
cd "${0%/*}"
BASE=..
docker stack deploy -c ${BASE}/local.yml bigdata