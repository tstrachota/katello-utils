#!/bin/bash
if [ $1 = "-i" ]; then
    echo "promoted product zoo to Dev"
    return
fi


$CMD product promote --name="zoo" --org="ACME_Corporation" --environment="Dev"



