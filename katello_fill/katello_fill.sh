#!/bin/sh

export KATELLO_CONFIG_FILE
source "$KATELLO_CONFIG_FILE"

SCRIPT_DIR=$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

KAT=$KAT_CLI_HOME/bin/katello
DATA_DIR=$SCRIPT_DIR/test_data

CMD="$KAT -u $KAT_USER -p $KAT_PASSWORD"

usage() {
cat <<USAGE
usage: $0 <DATA_SET_1> <DATA_SET_2> ..

OPTIONS:
  -h    Show this message
  -l    List available scripts

EXAMPLES:
  $0 demo sync_repos

USAGE
}

list_available_data() {
  printf "\nAvailable test data sets:\n"
  echo "--------------------------------------------------"
  
  pushd $DATA_DIR > /dev/null
  for f in *; do
    printf " - %s:\n" ${f%.sh}
    . ./$f -i | sed 's/^/    /g'
    echo
  done
  popd > /dev/null
}



while getopts "hl" opt; do
  case $opt in
    l)
      list_available_data
      exit
      ;;
    h)
      usage
      exit
      ;;
    ?)
      echo "Invalid option: $OPTARG" >&2
      usage
      exit
      ;;
  esac
done

if [ $# == 0 ]; then
  usage
  exit
fi;


for i in $@; do
    if [ ! -f "$DATA_DIR/$i.sh" ]; then
        printf "Required data set [ $i ] does not exist.\n"
        exit
    fi
done

for i in $@; do
    printf "Filling Katello with test data set [ $i ] ...\n"
    . $DATA_DIR/$i.sh 
done
