FROM node:8.11.2-jessie

EXPOSE 8080

RUN apt-get update && \
    mkdir -p /usr/src/app

WORKDIR /usr/src/app

RUN npm i -g nightwatch && \
    npm i -g http-server

CMD [ "bash" ]
