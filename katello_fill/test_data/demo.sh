#!/bin/bash
if [ $1 = "-i" ]; then
    echo "test data for ACME_Corporation"
    echo "environments: Locker > Dev > Prod"
    echo "providers:    porkchop"
    echo "products:     zoo, fake"
    echo "repos:        lzap's fake repos, my dummy repos"
    return
fi




$CMD environment create --name="Dev" --org="ACME_Corporation" --prior="Locker"
$CMD environment create --name="Prod" --org="ACME_Corporation" --prior="Dev"

$CMD provider create --name="porkchop"

$CMD product create --name="zoo" --provider="porkchop" --org="ACME_Corporation" --url="http://lzap.fedorapeople.org/fakerepos/zoo4/" --assumeyes
$CMD product create --name="fake" --provider="porkchop" --org="ACME_Corporation" --url="http://lzap.fedorapeople.org/fakerepos/fewupdates/" --assumeyes

