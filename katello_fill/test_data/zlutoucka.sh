#!/bin/bash
if [ $1 = "-i" ]; then
    echo "test data for localization"
    echo "orgs:         žluť"
    echo "providers:    žluť_provider (1 product)"
    echo "products:     žluť_product (1 repo)"
    echo "repos:        tstrachota's zoo"
    return
fi



$CMD org create --name="žluť"

$CMD provider create --name="žluť_provider" --org="žluť"

$CMD product create --name="žluť_product" --provider="žluť_provider" --org="žluť"
$CMD repo create --name="žluť_zoo" --product="žluť_product" --url="http://tstrachota.fedorapeople.org/dummy_repos/zoo/"  --org="žluť"




