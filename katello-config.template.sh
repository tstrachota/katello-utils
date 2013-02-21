#!/bin/sh

####### Katello settings #######

KAT_HOSTNAME='localhost'
KAT_PREFIX='katello'
KAT_PORT=''
KAT_THIN_PORT='5000'
KAT_USER='admin'
KAT_PASSWORD='admin'
KAT_PROTOCOL='https'

KAT_HOME=~/katello/
KAT_SRC_HOME="$KAT_HOME/src/"
KAT_CLI_HOME="$KAT_HOME/cli/"

if [ "$KAT_PORT" != "" ]; then SPACER=":"; else SPACER=""; fi
KAT_HOST="$KAT_PROTOCOL://$KAT_HOSTNAME$SPACER$KAT_PORT/$KAT_PREFIX"
KAT_API_URL="$KAT_HOST/api"



####### Candlepin settings #######

CP_HOSTNAME='localhost'
CP_PREFIX='candlepin'
CP_PORT='8443'
CP_USER='admin'
CP_PASSWORD='admin'
CP_OAUTH_KEY='katello'
CP_OAUTH_SECRET='your_oauth_secret'

if [ "$CP_PORT" != "" ]; then SPACER=":"; else SPACER=""; fi
CP_API_URL="https://$CP_HOSTNAME$SPACER$CP_PORT/$CP_PREFIX"

CP_SRC_HOME=""


####### Pulp settings #######

PULP_HOSTNAME='localhost'
PULP_PREFIX='pulp'
PULP_PORT='443'
PULP_USER='admin'
PULP_PASSWORD='admin'
PULP_PROTOCOL='https'

if [ "$PULP_PORT" != "" ]; then SPACER=":"; else SPACER=""; fi
PULP_API_URL="$PULP_PROTOCOL://$PULP_HOSTNAME$SPACER$PULP_PORT/$PULP_PREFIX/api"

PULP_SRC_HOME='/usr/lib/python2.7/site-packages/pulp'



####### Foreman settings #######

FOREMAN_HOSTNAME='localhost'
FOREMAN_PREFIX='foreman'
FOREMAN_PORT=''
FOREMAN_WEBRICK_PORT='5500'
FOREMAN_USER='admin'
FOREMAN_PASSWORD='changeme'
FOREMAN_PROTOCOL='http'

if [ "$FOREMAN_PORT" != "" ]; then SPACER=":"; else SPACER=""; fi
FOREMAN_API_URL="$FOREMAN_PROTOCOL://$FOREMAN_HOSTNAME$SPACER$FOREMAN_PORT/$FOREMAN_PREFIX/api"

FOREMAN_SRC_HOME=~/foreman/
