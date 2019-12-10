FROM quay.io/comp-bio-aging/spark-master:master

ENV SCALA_VERSION=2.11.12
ENV POLYNOTE_VERSION=0.2.11


WORKDIR /usr/src/app
ENV SCALA_VERSION=2.11.12
ENV POLYNOTE_VERSION=0.2.13

# Install pre-requisites needed for python dependencies
RUN set -e; \
  apk add --no-cache --virtual \
    .build-deps \
    gcc \
    g++ \
    libc-dev \
    linux-headers \
    mariadb-dev \
    python3-dev \
    postgresql-dev \
    freetype-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    zlib-dev \
    jpeg-dev \
  ;

# Install Python and dependencies

RUN conda install -y -c anaconda gcc_linux-64
RUN conda install -y pyspark virtualenv keras plotly
RUN conda install -y -c conda-forge jedi

# Install Python and dependencies
ENV PYTHONUNBUFFERED=1
COPY requirements.txt ./requirements.txt
RUN apk add python3-dev \
  && pip3 install --upgrade pip \
  && pip3 install jep

RUN conda clean -y --all

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