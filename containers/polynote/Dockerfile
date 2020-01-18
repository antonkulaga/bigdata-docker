FROM quay.io/comp-bio-aging/spark-base:master

WORKDIR /usr/src/app
ENV SCALA_VERSION=2.12.10
ENV POLYNOTE_VERSION=0.2.17


ARG POLYNOTE_VERSION
ARG SCALA_VERSION="2.12"
ARG DIST_TAR="polynote-dist-2.12.tar.gz"

WORKDIR /opt

RUN wget -q https://github.com/polynote/polynote/releases/download/$POLYNOTE_VERSION/$DIST_TAR && \
    tar xfzp $DIST_TAR && \
    echo "DIST_TAR=$DIST_TAR" && \
    rm $DIST_TAR

# allow user access to the WORKDIR
#RUN chown -R spark:spark /opt/
RUN chmod -R 777 /opt/

RUN  rm -rf \
         /var/lib/apt/lists/* \
         /tmp/* \
         /var/tmp/* \
         /usr/share/man \
         /usr/share/doc \
         /usr/share/doc-base \
         /root/.cache/pip

COPY config.yml ./polynote/config.yml

# expose the (internal) port that polynote runs on
EXPOSE 8192

USER spark

# start polynote on container run
CMD ["./polynote/polynote.py"]