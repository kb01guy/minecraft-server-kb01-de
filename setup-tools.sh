#!/bin/bash

BASEDIR=$(pwd)

# Helper
get_latest_release() {  # Source: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

# Install Essentials
#sudo apt-get update
#sudo apt-get -yq install git build-essential gnupg curl

# Open JDK install Zulu: Package-Manager apt
#sudo apt-key adv \
#  --keyserver hkp://keyserver.ubuntu.com:80 \
#  --recv-keys 0xB1998361219BD9C9
#sudo apt-get update
#sudo apt-get install zulu16-jdk

# Open JDK install Zulu: Direct Download
#curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-2_all.deb
#sudo apt-get install ./zulu-repo_1.0.0-2_all.deb

# Open JDK install Zulu: Portable
#curl -o jdk17.tar.gz https://cdn.azul.com/zulu/bin/zulu17.40.19-ca-jdk17.0.6-linux_x64.tar.gz
#tar xfz jdk17.tar.gz


# Create File Structure
mkdir -p ${BASEDIR}/.tools/buildtools && \
mkdir -p ${BASEDIR}/.tools/java && \

# Setup mcrcon
LATEST=$(get_latest_release Tiiffi/mcrcon)
curl -o ${BASEDIR}/tools/mcrcon/mcrcon https://github.com/Tiiffi/mcrcon/releases/download/${LATEST}/mcrcon-${LATEST[@]/v/}-windows-x86-64.zip
cd ${BASEDIR}/tools && git clone https://github.com/Tiiffi/mcrcon.git \
&& cd ${BASEDIR}/tools/mcrcon && gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c

# Setup Spigot
cd ${BASEDIR}/tools/buildtools && curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar \
&& java -jar BuildTools.jar --rev 1.17
