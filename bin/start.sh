#!/usr/bin/env bash
cd "${0%/*}"
BASE=..
docker stack deploy -c ${BASE}/docker-compose.yml bigdata