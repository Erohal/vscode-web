FROM ubuntu:20.04

# Close the interactive
ENV DEBIAN_FRONTEND noninteractive

# Update source.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse \
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse \
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse \
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse \
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse \
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse \
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse \
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse \
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse \
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" > /etc/apt/source.list

# Set up enviroment
RUN apt update -y > /dev/null && \
    apt upgrade -y && \
    apt install -y build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev python-is-python3 \
    pkg-config git make fakeroot rpm nodejs npm gvfs-bin apt-transport-https compizconfig-settings-manager python3 python3-pip apt-utils sodo > /dev/null

# Create user code and change workdir
RUN useradd --create-home --no-log-init --shell /bin/bash code && \
    adduser code sudo
USER code:code
WORKDIR /home/code
RUN mkdir ~/.npm-global
ENV NPM_CONFIG_PREFIX ~/.npm-global

RUN npm install -g yarn && \
    npm install -g keytar

# Checkout vscode
RUN git clone https://github.com/microsoft/vscode.git

# Set work dir to where the vscode is
WORKDIR /home/code/vscode

# Build vscode
RUN yarn
