FROM ubuntu:16.04

# python and relevant tools
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \ 
    build-essential \
    python3 \
    python \
    python-dev \
    libxml2-dev \
    libxslt-dev \
    libssl-dev \
    zlib1g-dev \
    libyaml-dev \
    libffi-dev \
    python-pip

# General dev tools
RUN apt-get install -y git

# Latest versions of python tools via pip
RUN pip install --upgrade pip \
                          virtualenv \
                          requests

RUN pip install awscli --upgrade

#                                      #
#           NODE STUFF 
#                                      #

RUN mkdir -p /usr/src/node

WORKDIR /usr/src/node

RUN apt-get install curl \ 
    && curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh \ 
    && bash nodesource_setup.sh \
    && apt-get install nodejs

#                                      #
#          SAUCE LABS STUFF
#                                      #

ENV SAUCE_DIR /usr/src/sauce-connect

ENV SC_VERSION 4.4.12

RUN mkdir -p ${SAUCE_DIR}

WORKDIR ${SAUCE_DIR}

RUN apt-get install wget \
    && wget https://saucelabs.com/downloads/sc-$SC_VERSION-linux.tar.gz -O - | tar -xz

RUN mv sc-$SC_VERSION-linux/* ./ && rm -rf sc-$SC_VERSION-linux

RUN export SC=$SAUCE_DIR

ADD start.sh $SAUCE_DIR
RUN chmod a+x $SAUCE_DIR/start.sh
















