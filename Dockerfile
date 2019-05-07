FROM ubuntu:18.04
LABEL maintainer "Ernesto Ruge <mail@ernestoruge.de>"
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ENV LC_ALL en_US.utf8
ENV LANGUAGE en_US.utf8

RUN apt-get update && \
    apt-get install -y locales apt-utils && \
    locale-gen en_US en_US.UTF-8 && \
    echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale  && \
    apt-get dist-upgrade -y && \
    apt-get autoremove -y && \
    apt-get clean
RUN apt-get update && apt-get install -y bzip2 ghostscript git-core graphviz lmodern pandoc pandoc-citeproc qpdf tar \
    zip python3 python3-pip python3-setuptools imagemagick \
    texlive texlive-lang-german texlive-latex-recommended texlive-generic-recommended texlive-fonts-recommended \
    texlive-latex-extra texlive-luatex texlive-xetex
RUN pip3 install pyyaml

RUN groupadd -g 1002 webdev
RUN useradd -u 1002 -g webdev -m -d /home/webdev -s /bin/bash webdev

ENV HOME /home/webdev
RUN mkdir /app
WORKDIR /app
COPY --chown=webdev:webdev . /app
USER webdev