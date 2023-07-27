FROM quay.io/comp-bio-aging/spark-master:2.13

WORKDIR /opt
ENV SCALA_VERSION=2.13.10
ENV POLYNOTE_VERSION=0.5.1
ENV POLYNOTE_SCALA_VERSION=2.13

WORKDIR /opt

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED TRUE
ENV LD_PRELOAD ${MAMBA_ROOT_PREFIX}/lib

RUN pip3 install \
  jep \
  jedi \
  pyspark==3.3.1 \
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