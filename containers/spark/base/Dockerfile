FROM quay.io/comp-bio-aging/java

MAINTAINER Anton Kulaga <antonkulaga@gmail.com>

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SPARK_VERSION=2.4.4
ENV HADOOP_VERSION=2.7

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

COPY spark-defaults.conf /spark/conf/

RUN pip install jep
RUN conda install -c conda-forge pyarrow
RUN conda install -y pyspark
RUN adduser --disabled-password -u 1002 spark
RUN chmod -R 777 /spark