#/bin/bash

# How to Execute this Multi-Purpose script:
# -----------------------------------------
# execute this Script in a Linux Console or Windows Powershell with:
# bash servertool

# fill script variables
BASEDIR=$(pwd)
COMMAND=$1;
shift
CONFIG=("$@")

# Help function prints information about usage of this script.
function print_help {
  echo -e "
Welcome to the All in one Minecraft Server Tool
-----------------------------------------------
Usage: servertool [command] [configuration]
COMMAND\tDESCRIPTION\t\t\tEXAMPLE
setup \tInteractive Setup
create \tCreates new configuration \tservertool create test

-----------------------------------------------";
#  echo -e "start \tStarts configuration";
#  echo -e "stop \tStops running configuration";
#  echo -e "status \tShows Information about configuration";
#  echo -e "remove \tRemoves configuration";
}

function list_server {
  echo -e "You have currently configured following Servers: "
  for i in $(ls -d */); do 
    echo ${i%%/}; 
  done
}

function create_info {
  echo -e "$1"
}

# Creates a new Server Configuration
function create_server {
  local name=$1; # any string-value, please no stupid characters
  local type=$2; # spigot, paper, bungeecord, waterfall, velocity, etc...
  echo -e "Creating Server $name running $type"
  echo -e "${#my_array[@]}"
  if [ -z "${#my_array[@]}" ]; then
    echo "Print create command Help"
  elif [ -d "$name" ]; then
    echo -e "Server $name allready exists!"
  else
#    mkdir "$name"
#    mkdir "$name/server"
    echo -e "version: '3.8'

services:
  $name:
    image: itzg/minecraft-server
    hostname: $name
    environment:
      TYPE: \"$type\"
      EULA: \"$eula\"
      JVM_XX_OPTS: \"-XX:MaxRAMPercentage=75\"
      ONLINE_MODE: \"$online\"
      SPIGET_RESOURCES: \"70616,7688,73997,34315,51856,16708,92546,28140,80677\"
    volumes:
      - ./mc-survival:/data"
  fi
}

# Select Command
if [[ -z "$COMMAND" || "$COMMAND" = "help" || "$COMMAND" = "--help" || "$COMMAND" = "-h" ]]; then
  print_help
elif [ "$COMMAND" = "create" ]; then
  echo "Creating Server";
  create_server $CONFIG;
elif [ "$COMMAND" = "create" ]; then
  list_server;
else
  print_help
fi
#if ("$COMMAND"=="" || "$COMMAND"=="help" || "$COMMAND"=="--help" || "$COMMAND"=="-h"); then
#  print_help;
#fi;





# Enable job control
set -m

while false :
do
    read -t 10 -p "input> " input
    [[ $input == finish ]] && break

    # set SIGINT to default action
    trap - SIGINT

    # Run the command in background
    bash -c "$input" &

    # Set our signal mask to ignore SIGINT
    trap "" SIGINT

    # Move the command back-into foreground
    fg %-

done

