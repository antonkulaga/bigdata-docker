FROM quay.io/comp-bio-aging/java

MAINTAINER Anton Kulaga <antonkulaga@gmail.com>

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SPARK_VERSION=2.4.4
ENV HADOOP_VERSION=2.8
ENV SPARK_HOME=/spark

ADD https://raw.githubusercontent.com/guilhem/apt-get-install/master/apt-get-install /usr/bin/
RUN chmod +x /usr/bin/apt-get-install

RUN wget http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop-scala-2.12.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-without-hadoop-scala-2.12.tgz \
      && mv spark-${SPARK_VERSION}-bin-without-hadoop-scala-2.12 spark \
      && rm spark-${SPARK_VERSION}-bin-without-hadoop-scala-2.12.tgz

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

# Fix the value of PYTHONHASHSEED
ENV PYTHONHASHSEED 1

COPY spark-defaults.conf /spark/conf/

RUN pip install jep
RUN conda install -c conda-forge pyarrow
RUN conda install -y pyspark
RUN adduser --disabled-password -u 1002 spark
RUN chmod -R 777 /spark