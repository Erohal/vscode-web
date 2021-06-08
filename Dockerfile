FROM ubuntu:20.04

SHELL ["/bin/bash","-c"]

# Close the interactive
ENV DEBIAN_FRONTEND noninteractive

# Set up enviroment
RUN apt-get update -y > /dev/null && \
    apt-get install -y build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev python-is-python3 \
    pkg-config git curl make fakeroot rpm nodejs npm gvfs-bin apt-transport-https compizconfig-settings-manager python3 python3-pip> /dev/null

WORKDIR /root

# Checkout vscode
RUN git clone https://github.com/microsoft/vscode.git

# Set work dir to where the vscode is
WORKDIR /root/vscode

RUN npm install -g npm && \
    npm install -g n && \
    n stable && \
    export PATH="$PATH" && \
    npm install -g yarn

# Build vscode
RUN yarn

# Make entrypoint script
RUN touch ENTRYPOINT.sh && echo "(yarn web &) && (yarn watch &)" > ENTRYPOINT.sh && chmod +x ENTRYPOINT.sh

ENTRYPOINT ["ENTRYPOINT.sh"]

EXPOSE 8080 8081

