FROM quay.io/comp-bio-aging/spark-base:master

COPY master.sh /

#RUN apk --update add coreutils procps

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /opt/spark/logs

RUN chmod -R 777 /opt/spark
RUN chmod +x /master.sh

WORKDIR /data

EXPOSE 8080 7077 6066
CMD ["/bin/bash", "/master.sh"]