#!/bin/bash

. "/opt/spark/sbin/spark-config.sh"

. "/opt/spark/bin/load-spark-env.sh"

mkdir -p $SPARK_WORKER_LOG

export SPARK_HOME=/opt/spark

ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker.out

#/spark/sbin/start-shuffle-service.sh

/opt/spark/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG/spark-worker.out
