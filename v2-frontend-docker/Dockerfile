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
ENV SAUCE_DIR /usr/src/sauce-connect

ENV SC_VERSION 4.4.12

RUN mkdir -p ${SAUCE_DIR}

WORKDIR ${SAUCE_DIR}

RUN apt-get install wget \
    && wget https://saucelabs.com/downloads/sc-$SC_VERSION-linux.tar.gz -O - | tar -xz

RUN mv sc-$SC_VERSION-linux/* ./ && rm -rf sc-$SC_VERSION-linux

RUN export SC=$SAUCE_DIR

ADD ./dockerFiles/start.sh $SAUCE_DIR

RUN chmod a+x $SAUCE_DIR/start.sh

RUN chmod a+x $SAUCE_DIR/bin/sc

EXPOSE 8080

WORKDIR /usr/src/app

ENV SHELL=/bin/bash

################################################################################
# VNC 
################################################################################
# ARG localbuild
# RUN if [ "x$localbuild" != "x" ]; then sed -i 's#http://archive.ubuntu.com/#http://tw.archive.ubuntu.com/#' /etc/apt/sources.list; fi

# # built-in packages
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends software-properties-common curl apache2-utils \
#     && add-apt-repository ppa:fcwu-tw/apps \
#     && apt-get update \
#     && apt-get install -y --no-install-recommends --allow-unauthenticated \
#         supervisor nginx sudo vim-tiny net-tools zenity xz-utils \
#         dbus-x11 x11-utils alsa-utils \
#         mesa-utils libgl1-mesa-dri \
#         lxde x11vnc xvfb \
#         gtk2-engines-murrine gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine arc-theme \
#         firefox \
#    #     firefox chromium-browser \
#         ttf-ubuntu-font-family ttf-wqy-zenhei \
#     && add-apt-repository -r ppa:fcwu-tw/apps \
#     && apt-get autoclean \
#     && apt-get autoremove \
#     && rm -rf /var/lib/apt/lists/*
# # Additional packages require ~600MB
# # libreoffice  pinta language-pack-zh-hant language-pack-gnome-zh-hant firefox-locale-zh-hant libreoffice-l10n-zh-tw

# # tini for subreap                                   
# ARG TINI_VERSION=v0.9.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
# RUN chmod +x /bin/tini

# # ffmpeg
# RUN mkdir -p /usr/local/ffmpeg \
#     && curl -sSL https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz | tar xJvf - -C /usr/local/ffmpeg/ --strip 1

# COPY dockerImageFiles /

# EXPOSE 80

# ENV HOME=/home/ubuntu \
#     SHELL=/bin/bash
# HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1/api/health

CMD [ "/bin/bash" ]
