FROM quay.io/comp-bio-aging/adam:master

MAINTAINER Anton Kulaga antonkulaga@gmail.com

ADD scripts /opt/adam/scripts/
#RUN curl -L -o /usr/local/bin/amm_2.11 https://git.io/vdNv2 && chmod +x /usr/local/bin/amm_2.11
RUN (echo "#!/usr/bin/env sh" && curl -L https://github.com/lihaoyi/Ammonite/releases/download/1.6.7/2.11-1.6.7) > /usr/local/bin/amm_2.11 && chmod +x /usr/local/bin/amm_2.11
WORKDIR /opt/adam/scripts

CMD ["amm_2.11"]