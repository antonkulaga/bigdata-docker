FROM bde2020/spark-base:2.4.4-hadoop2.7

MAINTAINER Anton Kulaga antonkulaga@gmail.com

ENV MAVEN_VERSION="3.6.3"

ENV MAVEN_HOME /opt/apache-maven-$MAVEN_VERSION

# we rely on apache maven > 3.1.1 to build ADAM, so we can't use the
# version of maven installed by apt-get
RUN mkdir /opt/apache-maven-$MAVEN_VERSION

RUN curl http://mirror.evowise.com/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  | tar --strip-components=1 -xzC /opt/apache-maven-$MAVEN_VERSION

ENV SPARK_HOME /spark/

WORKDIR /opt

# clone adam
RUN git clone https://github.com/bigdatagenomics/adam.git

# build adam
WORKDIR /opt/adam

#RUN /opt/adam/scripts/move_to_spark_2.sh

#RUN /opt/adam/scripts/move_to_scala_2.11.sh

RUN /opt/apache-maven-$MAVEN_VERSION/bin/mvn package -DskipTests

CMD ["/opt/adam/bin/adam-submit"]