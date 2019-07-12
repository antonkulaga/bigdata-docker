FROM frolvlad/alpine-miniconda3:latest

#temporaly copied from https://github.com/big-data-europe/docker-spark while waiting for their 2.4.3 release

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>
MAINTAINER Gezim Sejdiu <g.sejdiu@gmail.com>

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.7

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

ENV GLIBC_VERSION=2.29-r0 \
    GRAALVM_VERSION=19.0.2 \
    JAVA_HOME=/usr/lib/jvm/graalvm-ce-19.1.0 \
    PATH=/usr/lib/jvm/graalvm-ce-19.1.0/bin:$PATH

RUN apk --no-cache add ca-certificates wget gcc zlib zlib-dev libc-dev bash

RUN mkdir /usr/lib/jvm \
    && wget "https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz" \
    && tar -zxC /usr/lib/jvm -f graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz \
    && rm -f graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-$GLIBC_VERSION.apk" \
    &&  rm "glibc-$GLIBC_VERSION.apk" \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-bin-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-bin-$GLIBC_VERSION.apk" \
    &&  rm "glibc-bin-$GLIBC_VERSION.apk" \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-i18n-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-i18n-$GLIBC_VERSION.apk" \
    &&  rm "glibc-i18n-$GLIBC_VERSION.apk"


RUN apk add --no-cache curl bash python3 py-pip nss \
      && chmod +x *.sh \
      && wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
      && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      #&& cd /css \
      #&& jar uf /spark/jars/spark-core_2.11-${SPARK_VERSION}.jar org/apache/spark/ui/static/timeline-view.css \
      && cd /

RUN apk --update add coreutils procps

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

COPY spark-defaults.conf /spark/conf/

RUN conda install -c conda-forge pyarrow
RUN adduser -D -u 1002 spark