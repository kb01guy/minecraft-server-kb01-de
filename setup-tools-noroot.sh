#!/bin/bash

BASEDIR=$(pwd)

# Helper
get_latest_release() {  # Source: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

# Create File Structure
mkdir -p ${BASEDIR}/.tools/buildtools && \
mkdir -p ${BASEDIR}/.tools/mcrcon && \
mkdir -p ${BASEDIR}/.tools/java

# Setup mcrcon
cd ${BASEDIR}/.tools/mcrcon/ && \
LATEST=$(get_latest_release Tiiffi/mcrcon) && \
ARCHIVE_NAME="mcrcon-${LATEST[@]/v/}-linux-x86-64.tar.gz" && \
curl -L -o ${ARCHIVE_NAME} https://github.com/Tiiffi/mcrcon/releases/download/${LATEST}/${ARCHIVE_NAME} && \
tar xfz ${ARCHIVE_NAME}
#chmod +x mcrcon #Needed?

# Setup BuildTools
cd ${BASEDIR}/.tools/buildtools && \
curl -L -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
