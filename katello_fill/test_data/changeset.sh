#!/bin/bash
if [ $1 = "-i" ]; then
    echo "changesets cs1..cs6 for environment Dev"
    return
fi


$CMD changeset create --env="Dev" --org="ACME_Corporation" --name="cs1"
$CMD changeset create --env="Dev" --org="ACME_Corporation" --name="cs2"
$CMD changeset create --env="Dev" --org="ACME_Corporation" --name="cs3"
$CMD changeset create --env="Dev" --org="ACME_Corporation" --name="cs4"
$CMD changeset create --env="Dev" --org="ACME_Corporation" --name="cs5"
$CMD changeset create --env="Dev" --org="ACME_Corporation" --name="cs6"
