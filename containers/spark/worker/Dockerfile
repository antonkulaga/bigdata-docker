FROM quay.io/comp-bio-aging/spark-base:master

COPY worker.sh /

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /opt/spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

RUN chmod -R 777 /opt/spark
RUN chmod +x /worker.sh

WORKDIR /data

EXPOSE 8081
CMD ["/bin/bash", "/worker.sh"]