#!/bin/sh

. ~/Scripts/katello/katello_config.sh

export KATELLO_CONFIG_FILE
source "$KATELLO_CONFIG_FILE"


#get output of rake routes
cd $KAT_SRC_HOME
rake routes > $SCRIPT_DIR/files/kat_routes.txt

#crop only the unique routes form this file routes
cat $SCRIPT_DIR/files/kat_routes.txt | grep "/api/" | sed -e 's/(.:format)//g' -e 's/\/api//g' -e 's/\:[^/ ]*/ID/g' -e 's/[^/]*//' | awk '{print $1}' | sed -e 's/\/new$//' -e 's/\/edit$//' | sort -u > $SCRIPT_DIR/files/kat_routes_tmp_1.txt

#add ACME_Corporation to the cropped routes
cat $SCRIPT_DIR/files/kat_routes_tmp_1.txt > $SCRIPT_DIR/files/kat_routes_tmp_2.txt
cat $SCRIPT_DIR/files/kat_routes_tmp_1.txt | grep '/organizations/' | sed 's\/organizations/ID\/organizations/ACME_Corporation\' >> $SCRIPT_DIR/files/kat_routes_tmp_2.txt

#sort the file with routes
cat $SCRIPT_DIR/files/kat_routes_tmp_2.txt | sort -u > $SCRIPT_DIR/files/kat_routes_modified.txt

#create a file with sorted bits of routes
cat $SCRIPT_DIR/files/kat_routes_modified.txt | sed -e 's|/ID||g' -e 's|/| |g' | tr -s ' ' '\n' | egrep  "\w+" | sort -u > $SCRIPT_DIR/files/kat_routes_bits.txt
cd - > /dev/null

#delete temporary files
rm $SCRIPT_DIR/files/kat_routes_tmp_1.txt
rm $SCRIPT_DIR/files/kat_routes_tmp_2.txt


