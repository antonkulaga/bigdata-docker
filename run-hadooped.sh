#!/usr/bin/env bash
#docker network create -d overlay --attachable core
docker stack deploy -c hadooped.yml bigdata