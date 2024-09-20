#!/bin/bash

read -pr "Which OS are we installing? (sol/slack): " os

if [[ $os == "sol" ]]; then
    chmod u+x ./solaris/install.sh
    ./solaris/install.sh
elif [[ $os == "slack" ]]; then
    chmod u+x ./slackware/install.sh
    ./slackware/install.sh
fi
