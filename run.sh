#!/usr/bin/env bash
#docker network create -d overlay --attachable core
docker stack deploy -c bigdata-extended.yml bigdata