FROM ubuntu:20.04

SHELL ["/bin/bash","-c"]

# Close the interactive
ENV DEBIAN_FRONTEND noninteractive

# Set up enviroment
RUN apt update -y > /dev/null && \
    apt install -y build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev python-is-python3 \
    pkg-config git curl wget make fakeroot rpm nodejs npm gvfs-bin apt-transport-https compizconfig-settings-manager python3 python3-pip apt-utils > /dev/null

# Create user code and change workdir
#RUN useradd --create-home --no-log-init --shell /bin/bash code && \
#    adduser code sudo
#USER code:code
#WORKDIR /home/code

# Avoid EACCES
#RUN mkdir ~/.npm-global
#ENV NPM_CONFIG_PREFIX ~/.npm-global
#ENV PATH $PATH:~/.npm-global/bin

WORKDIR /root

# Checkout vscode
RUN git clone https://github.com/microsoft/vscode.git

# Set work dir to where the vscode is
WORKDIR /root/vscode

#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN npm install -g npm && \
    npm install -g n && \
    n stable && \
    PATH="$PATH" && \
    npm install -g yarn

# Build vscode
RUN yarn
