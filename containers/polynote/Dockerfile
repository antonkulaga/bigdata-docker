FROM quay.io/comp-bio-aging/spark-master:master

WORKDIR /opt
ENV SCALA_VERSION=2.12.14
ENV POLYNOTE_VERSION=0.4.3

WORKDIR /opt

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED TRUE

RUN pip3 install \
  jep \
  jedi \
  pyspark==3.2.0 \
  virtualenv \
  numpy \
  pandas

ENV PYSPARK_ALLOW_INSECURE_GATEWAY 1
ENV SPARK_HOME /opt/spark
ENV PATH "$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin"

# Download and extract polynote
RUN curl -Lk https://github.com/polynote/polynote/releases/download/${POLYNOTE_VERSION}/polynote-dist.tar.gz \
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
COPY config.yml /opt/polynote/config.yml
COPY notebooks /opt/polynote/notebooks
COPY run.sh /opt/polynote
RUN chmod +x /opt/polynote/run.sh


WORKDIR /opt/polynote

# expose the (internal) port that polynote runs on
EXPOSE 8192

# start polynote on container run
CMD ["/opt/polynote/polynote.py"]