#!/bin/bash
if [ $1 = "-i" ]; then
    echo "test data for ACME_Corporation"
    echo "environments: Locker > Dev > Prod"
    return
fi




$CMD environment create --name="Dev" --org="ACME_Corporation" --prior="Library"
$CMD environment create --name="Prod" --org="ACME_Corporation" --prior="Dev"

