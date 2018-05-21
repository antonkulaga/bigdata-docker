FROM bde2020/hadoop-base:2.0.0-hadoop2.7.4-java8
MAINTAINER Anton Kulaga <antonkulaga@gmail.com>

ENV APACHE_SPARK_VERSION 2.3.0
ENV APACHE_HADOOP_VERSION 2.7.5

RUN set -x \
    && curl -fSL "https://s3.eu-central-1.amazonaws.com/spark-notebook/tgz/spark-notebook-master-scala-2.11.8-spark-${APACHE_SPARK_VERSION}-hadoop-${APACHE_HADOOP_VERSION}.tgz?max-keys=100000" -o /tmp/spark-notebook.tgz \
    && tar -xzvf /tmp/spark-notebook.tgz -C /opt/ \
    && mv /opt/spark-notebook-* /opt/spark-notebook \
    && rm /tmp/spark-notebook.tgz

COPY run.sh /run.sh
RUN chmod a+x /run.sh

#COPY application.conf /opt/spark-notebook/conf/

RUN mkdir -p /data/resources

ENV NOTEBOOKS_DIR "/opt/spark-notebook/notebooks"
ENV RESOURCES_DIR "/data/resources"
ENV SPARK_MASTER "spark://spark-master:7077"
#ENV SPARK_EXECUTOR_MEMORY "12G"

#fetch dependencies
ENV FRAMELESS_VERSION "0.6.1"
ENV BETTER_FILES_VERSION "3.4.0"
ENV ADAM_VERSION "0.24.0"
ENV ADAM_PLAYGROUND_VERSION "0.0.11"
ENV CRISPR_VERSION "0.0.7"

RUN curl -L -o coursier https://git.io/vgvpD && chmod +x coursier
RUN ./coursier fetch \
    org.typelevel:frameless-cats_2.11:${FRAMELESS_VERSION} \
    org.typelevel:frameless-dataset_2.11:${FRAMELESS_VERSION} \
    com.github.pathikrit:better-files-akka_2.11:${BETTER_FILES_VERSION}

RUN ./coursier fetch \
    -r https://oss.sonatype.org/content/repositories/snapshots \
    -r https://dl.bintray.com/comp-bio-aging/main \
    -r https://dl.bintray.com/denigma/denigma-releases \
    org.bdgenomics.adam:adam-core-spark2_2.11:${ADAM_VERSION} \
    comp.bio.aging:adam-playground_2.11:${ADAM_PLAYGROUND_VERSION}

EXPOSE 9000

WORKDIR /opt/spark-notebook/

COPY clusters /opt/spark-notebook/conf/
COPY profiles /opt/spark-notebook/conf/

VOLUME ["/opt/spark-notebook/notebooks", "/root/.m2/repository"]

CMD ["/run.sh"]