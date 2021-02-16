FROM ubuntu:focal
LABEL maintainer="Tomasz Miller"

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y --no-install-recommends  \
        software-properties-common \
        xvfb \
        ca-certificates \
        curl \
        file \
        fonts-dejavu-core \
        g++ \
        git \
        locales \
        openjdk-8-jdk \
        maven \
        make \
        openssh-client \
        patch \
        uuid-runtime \
        unzip \
        jq \
        python3.8 \
    && rm -rf /var/lib/apt/lists/*

# Setting Java Home
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Default to UTF-8 file.encoding
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LANGUAGE=C.UTF-8

# Xvfb provide an in-memory X-session for tests that require a GUI
ENV DISPLAY=:99

# Create Bitbucket pipelines dirs and users
USER root
RUN mkdir -p /opt/atlassian/bitbucketci/agent/build \
    && sed -i '/[ -z \"PS1\" ] && return/a\\ncase $- in\n*i*) ;;\n*) return;;\nesac' /root/.bashrc \
    && useradd -m -s /bin/bash pipelines

WORKDIR /home/pipelines

# Installing AWS-SAM-CLI
RUN curl -L -o "awssamcli.zip" "https://github.com/aws/aws-sam-cli/releases/download/v1.18.1/aws-sam-cli-linux-x86_64.zip" \
    && unzip -d awssamcli awssamcli.zip \
    && ./awssamcli/install
RUN sam --version

# Installing AWS-CLI
RUN curl -L -o "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    && unzip awscliv2.zip \
    && ./aws/install
RUN aws --version

USER pipelines

# Installing nvm with node and npm
RUN mkdir -p /home/pipelines/.nvm

ENV NODE_VERSION=14.15.4 \
    NVM_DIR=/home/pipelines/.nvm \
    NVM_VERSION=0.37.2

RUN curl https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Setting node path
ENV NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules

# Adding Nvm and Node to the path
ENV PATH=$NVM_DIR:$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /opt/atlassian/bitbucketci/agent/build
ENTRYPOINT /bin/bash

RUN java -version
RUN mvn --version
RUN node -v
RUN npm -v

RUN npm install --global yarn