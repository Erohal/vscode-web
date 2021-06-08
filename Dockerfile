FROM ubuntu:20.04

# Close the interactive
ENV DEBIAN_FRONTEND noninteractive

RUN apt autoremove cmdtest && apt autoremove yarn && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Set up enviroment
RUN apt update -y > /dev/null && \
    apt install -y build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev python-is-python3 \
    pkg-config git make fakeroot rpm nodejs npm gvfs-bin apt-transport-https compizconfig-settings-manager python3 python3-pip apt-utils yarn > /dev/null

# Create user code and change workdir
RUN useradd --create-home --no-log-init --shell /bin/bash code && \
    adduser code sudo
USER code:code
WORKDIR /home/code
RUN mkdir ~/.npm-global
ENV NPM_CONFIG_PREFIX ~/.npm-global

# Checkout vscode
RUN git clone https://github.com/microsoft/vscode.git

# Set work dir to where the vscode is
WORKDIR /home/code/vscode

RUN npm install -g keytar

# Build vscode
RUN yarn
