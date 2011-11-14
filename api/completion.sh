#!/bin/sh

SCRIPT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/completion/api_completion.sh

ROUTES_DIR="$SCRIPT_DIR/completion/files/"


function _katapi() {
  complete_api "$ROUTES_DIR/kat_routes_modified.txt"  "$ROUTES_DIR/kat_routes_bits.txt"
}

function _cpapi() {
  complete_api "$ROUTES_DIR/cp_routes_modified.txt"  "$ROUTES_DIR/cp_routes_bits.txt"
}

function _pulpapi() {
  complete_api "$ROUTES_DIR/pulp_routes_modified.txt"  "$ROUTES_DIR/pulp_routes_bits.txt"
}


complete -F _katapi kat-api
complete -F _cpapi cp-api
complete -F _pulpapi pulp-api
