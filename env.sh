#!/bin/sh

export ADMIN="KillTheIdols"
export CLUSTER_NAME="CLUSTER_NAME"

# No really necessary but oh well
export WEB_PORT=1234

# The container needs to be named this, so use a portion of the hostname, no : or / etc
export HOSTNAME="master"

# Where to connect, disable external access on your firewall probably
export WEB_ADDR="http://$HOSTNAME:1234/"
