#!/bin/sh

SCRIPT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. $SCRIPT_DIR/../../config.sh


#get output of buildr apicrawl
cd $CP_SRC_HOME
buildr candlepin:apicrawl

#crop only the unique routes form this file routes
cat target/candlepin_methods.json | json_reformat | grep "url" | sed -e 's/^[ ]*"url":[ ]*"//' -e 's/",[ ]*$//' -e 's/{.*}/ID/' | sort -u > $SCRIPT_DIR/files/cp_routes_modified.txt

#create a file with sorted bits of routes
cat $SCRIPT_DIR/files/cp_routes_modified.txt | sed -e 's|/ID||g' -e 's|/| |g' | tr -s ' ' '\n' | egrep  "\w+" | sort -u > $SCRIPT_DIR/files/cp_routes_bits.txt
cd - > /dev/null
