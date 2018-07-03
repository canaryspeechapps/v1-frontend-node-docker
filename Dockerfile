FROM ubuntu:16.04

# python and relevant tools
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \ 
    apt-utils \
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

RUN apt-get install -y wget


# Latest versions of python tools via pip
RUN pip install --upgrade pip \
                          virtualenv \
                          requests

#                                      #
#           JAVA 8
#                                      #
RUN apt-get install openjdk-8-jre -y

#                                      #
#           aws cli 
#                                      #
RUN pip install awscli --upgrade

#                                      #
#           NODE STUFF 
#                                      #

RUN mkdir -p /usr/src/node

WORKDIR /usr/src/node

#                                      #
#                NODE 
#                                      #
RUN apt-get install curl \ 
    && curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh \ 
    && bash nodesource_setup.sh \
    && apt-get install nodejs

#                                      #
#       NIGHTWATCH + HTTP-SERVER
#                                      #
RUN npm i -g nightwatch \
    && npm i -g http-server \
    && mkdir -p /usr/src/app

#                                      #
#      CHROME - for nightwatch 
#                                      #
RUN mkdir -p /usr/src/tmp

WORKDIR /usr/src/tmp

# Add a user for running applications.
RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

# Install x11vnc.
RUN apt-get install -y x11vnc
# Install xvfb.
RUN apt-get install -y xvfb
# Install fluxbox.
RUN apt-get install -y fluxbox
# Install wget.
RUN apt-get install -y wget
# Install wmctrl.
RUN apt-get install -y wmctrl
# Set the Chrome repo.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# Install Chrome.
RUN apt-get update && apt-get -y install google-chrome-stable

RUN rm -rf google.list google.list.save

RUN apt-get update -y
# RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
#     && dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

#                                      #
#          SAUCE LABS STUFF
#                                      #
# ENV SAUCE_DIR /usr/src/sauce-connect

# ENV SC_VERSION 4.4.12

# RUN mkdir -p ${SAUCE_DIR}

# WORKDIR ${SAUCE_DIR}

# RUN apt-get install wget \
#     && wget https://saucelabs.com/downloads/sc-$SC_VERSION-linux.tar.gz -O - | tar -xz

# RUN mv sc-$SC_VERSION-linux/* ./ && rm -rf sc-$SC_VERSION-linux

# RUN export SC=$SAUCE_DIR

# ADD start.sh $SAUCE_DIR

# RUN chmod a+x $SAUCE_DIR/start.sh

# RUN chmod a+x $SAUCE_DIR/bin/sc

# EXPOSE 8080

WORKDIR /usr/src/app

CMD [ "/bin/bash" ]