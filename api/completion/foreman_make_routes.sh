#!/bin/sh

SCRIPT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export KATELLO_CONFIG_FILE
source "$KATELLO_CONFIG_FILE"

#get output of rake routes
cd $FOREMAN_SRC_HOME
bundle exec rake routes > $SCRIPT_DIR/files/foreman_routes.txt

#crop only the unique routes form this file routes
cat $SCRIPT_DIR/files/foreman_routes.txt | grep "/api/" | sed -e 's/(.:format)//g' -e 's/\/api//g' -e 's/\:[^/ ]*/ID/g' -e 's/[^/]*//' | awk '{print $1}' | sed -e 's/\/new$//' -e 's/\/edit$//' | egrep -e '^/[a-z].*$' | sort -u > $SCRIPT_DIR/files/foreman_routes_tmp_1.txt

#sort the file with routes
cat $SCRIPT_DIR/files/foreman_routes_tmp_1.txt | sort -u > $SCRIPT_DIR/files/foreman_routes_modified.txt

#create a file with sorted bits of routes
cat $SCRIPT_DIR/files/foreman_routes_modified.txt | sed -e 's|/ID||g' -e 's|/| |g' | tr -s ' ' '\n' | egrep  "\w+" | sort -u > $SCRIPT_DIR/files/foreman_routes_bits.txt
cd - > /dev/null

#delete temporary files
rm $SCRIPT_DIR/files/foreman_routes_tmp_1.txt


