FROM ubuntu:20.04

ENV CROCO_DIR /opt/croco
ENV CROCO_VERSION 1.1

RUN DEBIAN_FRONTEND=noninteractive apt-get update \ 
    && apt-get install -y --fix-missing --no-install-recommends \ 
        make wget gcc gfortran libnetcdf-dev libnetcdff-dev

RUN mkdir -p $CROCO_DIR \
    && cd $CROCO_DIR \
    && wget ftp://ftp.ifremer.fr/ifremer/croco/CODE_ARCHIVE/croco-v${CROCO_VERSION}.tar.gz \
    && wget ftp://ftp.ifremer.fr/ifremer/croco/CODE_ARCHIVE/croco_tools-v${CROCO_VERSION}.tar.gz \
    && tar -zxvf croco_tools-v${CROCO_VERSION}.tar.gz \
    && tar -zxvf croco-v${CROCO_VERSION}.tar.gz \
    && mkdir CONFIGS \
    && mv croco-v${CROCO_VERSION} croco && mv croco_tools-v${CROCO_VERSION} croco_tools \
    && rm -rf croco-v${CROCO_VERSION}.tar.gz croco_tools-v${CROCO_VERSION}.tar.gz 

WORKDIR $CROCO_DIR

ADD create_run.bash create_run.bash
