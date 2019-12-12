FROM quay.io/comp-bio-aging/spark-master:master


WORKDIR /usr/src/app
ENV SCALA_VERSION=2.11.12
ENV POLYNOTE_VERSION=0.2.13

# Install Python and dependencies

RUN ln -s /opt/conda/bin/pip /usr/bin/pip3

RUN conda install -y -c conda-forge jedi pyspark virtualenv keras plotly && conda clean -y --all

# Download and extract polynote
RUN curl -Lk https://github.com/polynote/polynote/releases/download/${POLYNOTE_VERSION}/polynote-dist.tar.gz \
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

EXPOSE 8192

CMD bash polynote/polynote