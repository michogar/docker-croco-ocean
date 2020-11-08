FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update \ 
    && apt-get install -y --fix-missing --no-install-recommends \ 
        wget gcc gfortran libnetcdf-dev libnetcdff-dev

RUN wget ftp://ftp.ifremer.fr/ifremer/croco/CODE_ARCHIVE/croco-v1.1.tar.gz \
    && wget ftp://ftp.ifremer.fr/ifremer/croco/CODE_ARCHIVE/croco_tools-v1.1.tar.gz \
    && tar -zxvf croco_tools-v1.1.tar.gz \
    && tar -zxvf croco-v1.1.tar.gz \
    && mkdir croco CONFIGS \
    && mv croco-v1.1 croco/croco && mv croco_tools-v1.1 croco/croco_tools \
    && rm -rf croco-v1.1.tar.gz croco_tools-v1.1.tar.gz 