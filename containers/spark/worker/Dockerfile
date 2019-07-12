FROM quay.io/comp-bio-aging/spark-base:master

COPY worker.sh /

RUN apk update
RUN apk --update add coreutils procps
RUN apk add rsync openssh

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

EXPOSE 8081
RUN useradd -r -u 1002 spark
CMD ["/bin/bash", "/worker.sh"]