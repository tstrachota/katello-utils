#!/bin/bash

ORG="ACME_Corporation"
REPO="http://dl.google.com/linux/chrome/rpm/stable/x86_64"
TMP_KEY="/tmp/google_key.pub"

if [ $1 = "-i" ]; then
    echo "test data for $ORG"
    echo "providers:    google"
    echo "products:     chrome"
    echo "repos:        chrome x86_64 stable"
    return
fi

wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O $TMP_KEY 

$CMD gpg_key create --name="google_key" --file="$TMP_KEY" --org="$ORG"
$CMD provider create --name="google" --org="$ORG"
$CMD product create --name="chrome" --provider="google" --org="$ORG" --gpgkey="google_key"
$CMD repo create --name="chrome_x86" --url="$REPO" --product="chrome" --org="$ORG"

rm $TMP_KEY 
