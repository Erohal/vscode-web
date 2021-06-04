FROM ubuntu:latest

LABEL author="Erohal"
LABEL email="ErohalTheBest@gmail.com"
LABEL version="0.1"

# Close the interactive
ENV DEBIAN_FRONTEND noninteractive

# Set up enviroment
RUN apt update -y && \
    apt install -y build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev python-is-python3 \
    pkg-config git make fakeroot rpm nodejs npm gvfs-bin apt-transport-https compizconfig-settings-manager && \
    npm install -g yarn && \
    npm install -g keytar

# Checkout vscode
RUN git clone https://github.com/microsoft/vscode.git

# Set work dir to where the vscode is
WORKDIR /vscode

# Build vscode
RUN chmod -R 777 /root/.npm && yarn
