FROM bde2020/spark-base:2.4.4-hadoop2.7

MAINTAINER Anton Kulaga antonkulaga@gmail.com

ENV MAVEN_VERSION="3.6.2"

ENV MAVEN_HOME /opt/apache-maven-$MAVEN_VERSION

# we rely on apache maven > 3.1.1 to build ADAM, so we can't use the
# version of maven installed by apt-get
RUN mkdir /opt/apache-maven-$MAVEN_VERSION

RUN curl http://mirror.evowise.com/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  | tar --strip-components=1 -xzC /opt/apache-maven-$MAVEN_VERSION

ENV SPARK_HOME /spark/

WORKDIR /opt

#clone mango
RUN git clone https://github.com/bigdatagenomics/mango.git

WORKDIR /opt/mango

RUN /opt/mango/scripts/move_to_spark_2.sh

RUN /opt/mango/scripts/move_to_scala_2.11.sh

RUN /opt/apache-maven-$MAVEN_VERSION/bin/mvn package -DskipTests

ENTRYPOINT ["/opt/adam/bin/adam-submit"]