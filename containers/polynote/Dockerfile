FROM quay.io/comp-bio-aging/spark-master:master

WORKDIR /opt
ENV SCALA_VERSION=2.12.11
ENV POLYNOTE_VERSION=0.3.7
#ENV SPARK_DIST_CLASSPATH=/etc/hadoop:/opt/hadoop-2.9.2/share/hadoop/common/lib/*:/opt/hadoop-2.9.2/share/hadoop/common/*:/opt/hadoop-2.9.2/share/hadoop/hdfs:/opt/hadoop-2.9.2/share/hadoop/hdfs/lib/*:/opt/hadoop-2.9.2/share/hadoop/hdfs/*:/opt/hadoop-2.9.2/share/hadoop/yarn:/opt/hadoop-2.9.2/share/hadoop/yarn/lib/*:/opt/hadoop-2.9.2/share/hadoop/yarn/*:/opt/hadoop-2.9.2/share/hadoop/mapreduce/lib/*:/opt/hadoop-2.9.2/share/hadoop/mapreduce/*:/contrib/capacity-scheduler/*.jar

# Download and extract polynote
RUN curl -Lk https://github.com/polynote/polynote/releases/download/${POLYNOTE_VERSION}/polynote-dist-2.12.tar.gz \
  | tar -xzvpf -

RUN  rm -rf \
         /var/lib/apt/lists/* \
         /tmp/* \
         /var/tmp/* \
         /usr/share/man \
         /usr/share/doc \
         /usr/share/doc-base \
         /root/.cache/pip
RUN mkdir /tmp/spark-events && chmod -R 777 /tmp/spark-events
COPY config.yml ./polynote/config.yml

# expose the (internal) port that polynote runs on
EXPOSE 8192

# start polynote on container run
CMD ["./polynote/polynote.py"]