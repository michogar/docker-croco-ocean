FROM ubuntu:20.04

RUN apt-get update \ 
    && apt-get install -y wget libnetcdf-dev libnetcdff-dev

RUN wget ftp://ftp.ifremer.fr/ifremer/croco/CODE_ARCHIVE/croco-v1.1.tar.gz \
    && wget ftp://ftp.ifremer.fr/ifremer/croco/CODE_ARCHIVE/croco_tools-v1.1.tar.gz \
    && tar -zxvf croco_tools-v1.1.tar.gz \
    && tar -zxvf croco-v1.1.tar.gz \
    && mv croco-v1.1 croco && mv croco_tools-v1.1 croco_tools