FROM quay.io/comp-bio-aging/java

MAINTAINER Anton Kulaga <antonkulaga@gmail.com>

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SPARK_VERSION=2.4.5
ENV SPARK_HOME=/opt/spark

ADD https://raw.githubusercontent.com/guilhem/apt-get-install/master/apt-get-install /usr/bin/
RUN chmod +x /usr/bin/apt-get-install
RUN mkdir /tmp/spark-events && chmod -R 777 /tmp/spark-events
WORKDIR /opt

#INSTALL HADOOP

ENV HADOOP_VERSION=2.10.0
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

COPY scheduler.xml /opt/spark/conf

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

COPY spark-defaults.conf /opt/spark/conf/

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

COPY hive-site.xml /opt/spark/conf/
COPY spark-env.sh /opt/spark/conf/

RUN apt-get install -y rsync


# Install Python and dependencies

RUN pip install jep
RUN conda install -c conda-forge pyarrow
RUN conda install -y -c conda-forge pyspark

RUN ln -s /opt/conda/bin/pip /usr/bin/pip3
RUN conda install -y -c conda-forge jedi virtualenv keras plotly && conda clean -y --all

RUN echo "source activate" > ~/.bashrc
RUN export SPARK_DIST_CLASSPATH=$(hadoop classpath);echo $SPARK_DIST_CLASSPATH;
RUN bash -l -c 'echo export SPARK_DIST_CLASSPATH="$(hadoop classpath)" >> /etc/bash.bashrc'

ENV PATH /opt/conda/envs/env/bin:$PATH

RUN adduser --disabled-password -u 1002 spark
RUN chmod -R 777 /opt/spark

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
CMD ["entrypoint.sh"]