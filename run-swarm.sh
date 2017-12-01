#!/usr/bin/env bash
docker network create -d overlay --attachable core
docker stack deploy -c hadoop-swarm.yml hadoop
docker stack deploy -c spark-swarm.yml hadoop