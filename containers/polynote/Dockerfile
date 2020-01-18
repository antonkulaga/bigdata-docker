FROM quay.io/comp-bio-aging/spark-master:master

WORKDIR /usr/src/app
ENV SCALA_VERSION=2.12.10
ENV POLYNOTE_VERSION=0.2.17

ENV NB_USER=polynote

# Install Python and dependencies

RUN ln -s /opt/conda/bin/pip /usr/bin/pip3

RUN conda install -y -c conda-forge jedi pyspark virtualenv keras plotly && conda clean -y --all

# Download and extract polynote
RUN curl -Lk https://github.com/polynote/polynote/releases/download/${POLYNOTE_VERSION}/polynote-dist-2.12.tar.gz \
  | tar -xzvpf -

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

#RUN useradd -r -u 1002 $NB_USER
#ENV EUID=1002

# start polynote on container run
CMD ["./polynote/polynote.py"]