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

WORKDIR /

#INSTALL HADOOP

ENV HADOOP_VERSION 2.9.2
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1

ENV PATH $HADOOP_PREFIX/bin/:$PATH

#INSTALL SPARK

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

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

COPY hive-site.xml /spark/conf/
COPY spark-env.sh /spark/conf/

RUN pip install jep
RUN conda install -c conda-forge pyarrow
RUN conda install -y pyspark
RUN adduser --disabled-password -u 1002 spark
RUN chmod -R 777 /spark

RUN export SPARK_DIST_CLASSPATH=$(hadoop classpath)

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
CMD ["entrypoint.sh"]