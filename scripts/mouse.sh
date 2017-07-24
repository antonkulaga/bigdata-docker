#!/usr/bin/env bash

docker run -p 9999:9999 -p 4040:4040 --net=bigdatadocker_default -v /pipelines/bigdata-docker:/data quay.io/comp-bio-aging/adam:latest --master spark://spark-master:7077 --conf spark.driver.port=9999 --executor-memory 22G --total-executor-cores 8 -- fasta2adam hdfs://namenode:8020/genomes/MOUSE/M14/GRCm38.p5.genome.fa.gz hdfs://namenode:8020/genomes/MOUSE/M14/genome.adam -fragment_length 10000
