FROM apache/zeppelin:0.8.1
MAINTAINER Anton Kulaga <antonkulaga@gmail.com>

ENV SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.7
ENV SPARK_HOME=/zeppelin/spark

ADD https://raw.githubusercontent.com/guilhem/apt-get-install/master/apt-get-install /usr/bin/
RUN chmod +x /usr/bin/apt-get-install

RUN mkdir logs && mkdir run

RUN apt-get-install -y curl \
      && wget http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
      && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN apt-get-install -y python3 python3-setuptools python3-pip

COPY conf/interpreter.json /zeppelin/conf/interpreter.json

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV ZEPPELIN_INTERPRETER_OUTPUT_LIMIT=92160000
ENV ZEPPELIN_INTP_MEM="-Xms1024m -Xmx16G -XX:MaxPermSize=1024m"
ENV ZEPPELIN_INTERPRETER_OUTPUT_LIMIT=92160000
ENV ZEPPELIN_SPARK_MAXRESULT=5000
ENV ZEPPELIN_WEBSOCKET_MAX_TEXT_MESSAGE_SIZE=2048000
ENV ZEPPELIN_SPARK_CONCURRENTSQL=true

COPY conf/zeppelin-env.sh /zeppelin/conf/zeppelin-env.sh