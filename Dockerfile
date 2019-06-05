# Base image

FROM ubuntu:19.10

# Install of git, curl, apt-utils etc

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y curl \
    && apt-get install -y git \
    && apt-get -y autoclean \
    && apt-get install -y zsh \
    && apt-get install -y software-properties-common

RUN rm /bin/sh && ln -s /bin/zsh /bin/sh

# NVM and Node Setup

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.16.0
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# rsync

RUN apt-get -y install rsync

# Install Java JRE
RUN apt-get install -y default-jre

