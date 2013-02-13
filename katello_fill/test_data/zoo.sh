#!/bin/bash
if [ $1 = "-i" ]; then
    echo "test data for ACME_Corporation"
    echo "providers:    petshop (1 product), safari (no products)"
    echo "products:     zoo (2 repos)"
    echo "repos:        tstrachota's zoo & updated zoo repos"
    return
fi




$CMD provider create --name="petshop" --org="ACME_Corporation"
$CMD provider create --name="safari" --org="ACME_Corporation"

$CMD product create --name="zoo" --provider="petshop" --org="ACME_Corporation"
$CMD repo create --name="zoo" --product="zoo" --url="http://tstrachota.fedorapeople.org/dummy_repos/zoo/" --org="ACME_Corporation"
$CMD repo create --name="up_zoo" --product="zoo" --url="http://tstrachota.fedorapeople.org/dummy_repos/updated_zoo/" --org="ACME_Corporation"



