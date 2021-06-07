FROM ubuntu:latest

# Close the interactive
ENV DEBIAN_FRONTEND noninteractive

# Set up enviroment
RUN apt update -y > /dev/null && \
    apt install -y build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev python-is-python3 \
    pkg-config git make fakeroot rpm nodejs npm gvfs-bin apt-transport-https compizconfig-settings-manager python3 python3-pip > /dev/null

# Create user code and change workdir
RUN useradd --create-home --no-log-init --shell /bin/bash —-disable-password code && \
    adduser code sudo
USER code:code
WORKDIR /home/code
RUN mkdir ~/.npm-global
ENV NPM_CONFIG_PREFIX ~/.npm-global

# Install dependence of vscode
RUN npm install -g yarn && \
    npm install -g keytar


# Checkout vscode
RUN git clone https://github.com/microsoft/vscode.git

# Set work dir to where the vscode is
WORKDIR /home/code/vscode

# Build vscode
RUN yarn
