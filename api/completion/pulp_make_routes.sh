#!/bin/sh

SCRIPT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. $SCRIPT_DIR/../../config.sh


controllers_path="$PULP_SRC_HOME/server/webservices/controllers"; 

#get paths from doc string of controllers
echo "" > $SCRIPT_DIR/files/pulp_routes.txt
for i in `ls $controllers_path`; do 
    cat "$controllers_path/$i" | grep "path:" | sed -e "s/^[ ]*path:[ ]*//" -e "s/<id>/ID/" -e "s/<action name>/ACTION_NAME/" -e "s/<.*>/ID/" >> $SCRIPT_DIR/files/pulp_routes.txt 
done

#crop only the unique routes form this file routes
cat $SCRIPT_DIR/files/pulp_routes.txt | sort -u > $SCRIPT_DIR/files/pulp_routes_modified.txt

#create a file with sorted bits of routes
cat $SCRIPT_DIR/files/pulp_routes_modified.txt | sed -e 's|/ID||g' -e 's|/| |g' | tr -s ' ' '\n' | egrep  "\w+" | sort -u > $SCRIPT_DIR/files/pulp_routes_bits.txt
