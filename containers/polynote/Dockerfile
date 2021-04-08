FROM quay.io/comp-bio-aging/spark-master:master

WORKDIR /opt
ENV SCALA_VERSION=2.12.13
ENV POLYNOTE_VERSION=0.4.0

WORKDIR /opt

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED TRUE

RUN pip3 install \
  jep \
  jedi \
  pyspark==3.1.1 \
  virtualenv \
  numpy \
  pandas

ENV PYSPARK_ALLOW_INSECURE_GATEWAY 1
ENV SPARK_HOME /opt/spark
ENV PATH "$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin"

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