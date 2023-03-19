#!/bin/bash

# Encryption only needed if Connected Servers are on different Machines
#docker network create --opt encrypted --driver overlay --attachable minecraft-backend
docker network create --driver overlay --attachable minecraft-backend