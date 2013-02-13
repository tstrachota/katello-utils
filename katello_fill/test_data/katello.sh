#!/bin/bash

ORG="ACME_Corporation"
REPO="http://fedorapeople.org/groups/katello/releases/yum/nightly/RHEL/6/"

if [ $1 = "-i" ]; then
    echo "test data for $ORG"
    echo "providers:    katello"
    echo "products:     katello"
    echo "repos:        one katello repo"
    return
fi


$CMD provider create --name="katello" --org="$ORG"
$CMD product create --name="katello" --provider="katello" --org="$ORG" --url="$REPO" --assumeyes


