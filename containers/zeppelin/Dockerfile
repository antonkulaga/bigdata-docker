FROM quay.io/comp-bio-aging/spark-base:master
#FROM apache/zeppelin:0.8.2
MAINTAINER Anton Kulaga <antonkulaga@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Europe/Bucharest /etc/localtime

# `Z_VERSION` will be updated by `dev/change_zeppelin_version.sh`
ENV Z_VERSION="0.9.0"
ENV LOG_TAG="[ZEPPELIN_${Z_VERSION}]:" \
    Z_HOME="/zeppelin" \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

ENV SPARK_HOME=/spark

RUN echo "$LOG_TAG install tini related packages" && \
    apt-get install -y wget curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb


RUN apt-get install -y python3 python3-setuptools python3-pip npm libfontconfig r-base-dev r-cran-evaluate
RUN git clone https://github.com/apache/zeppelin.git
WORKDIR zeppelin

ENV MAVEN_VERSION="3.6.3"

ENV MAVEN_HOME /opt/apache-maven-$MAVEN_VERSION

# we rely on apache maven > 3.1.1 to build ADAM, so we can't use the
# version of maven installed by apt-get
RUN mkdir /opt/apache-maven-$MAVEN_VERSION

RUN curl http://mirror.evowise.com/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  | tar --strip-components=1 -xzC /opt/apache-maven-$MAVEN_VERSION

RUN mvn clean package -DskipTests -Pspark-2.4 -Phadoop-2.6 -Pscala-2.12 -Dspark.version=2.4.5

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

ENV ZEPPELIN_INTERPRETER_OUTPUT_LIMIT=92160000
ENV ZEPPELIN_INTP_MEM="-Xms1024m -Xmx16G -XX:MaxPermSize=1024m"
ENV ZEPPELIN_INTERPRETER_OUTPUT_LIMIT=92160000
ENV ZEPPELIN_SPARK_MAXRESULT=5000
ENV ZEPPELIN_WEBSOCKET_MAX_TEXT_MESSAGE_SIZE=2048000
ENV ZEPPELIN_SPARK_CONCURRENTSQL=true


COPY conf/zeppelin-env.sh /zeppelin/conf/zeppelin-env.sh
RUN useradd -r -u 1002 zeppelin
RUN chmod -R 777 /zeppelin

WORKDIR /zeppelin
ENTRYPOINT [ "/usr/bin/tini", "--" ]
WORKDIR ${Z_HOME}
CMD ["bin/zeppelin.sh"]