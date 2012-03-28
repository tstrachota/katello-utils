#!/bin/sh

SCRIPT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/../config.sh

# Use curl to call the api
# 1st param: hostname
# 2nd param: user:password
# 3rd param: relative path
# 4th param: method (get, put, post, delete)
# 5th param: data
call-api() {
  h_name=$1; shift
  usr_psswd=$1; shift
  path=$1; shift
  method=$1; shift
  data=$@
    
  if [ -n "$method" ]; then
    method="-X $method"
    method="`echo $method | tr '[:lower:]' '[:upper:]'`"
  else
    method=""
  fi

  
  if [ -n "$data" ]; then
    echo "curl -H \"Content-Type: application/json\" -H \"Accept: application/json\" $method -d "$data" -k -u $usr_psswd $h_name$path"
    response=`curl -H "Content-Type: application/json" -H "Accept: application/json" $method -d "$data" -k -u $usr_psswd $h_name$path`
  else
    echo "curl -H \"Content-Type: application/json\" -H \"Accept: application/json\" $method -k -u $usr_psswd $h_name$path"
    response=`curl -H "Content-Type: application/json" -H "Accept: application/json" $method -k -u $usr_psswd $h_name$path`
  fi
  echo $response | json_reformat &> /dev/null

  if [ $? == 0 ]; then
    echo $response | json_reformat
  else
    echo $response
  fi
}


# Use curl to call the api
# 1st param: hostname
# 2nd param: user
# 3rd param: oauth key
# 4th param: oauth secret
# 5th param: relative path
# 6th param: method (get, put, post, delete)
# 7th param: data
call-oauth-api() {
  h_name=$1; shift
  user=$1; shift
  key=$1; shift
  secret=$1; shift
  path=$1; shift
  method=$1; shift
  data=$@
    
  if [ -n "$method" ]; then
    method="`echo $method | tr '[:lower:]' '[:upper:]'`"
  else
    method="GET"
  fi

  echo "$SCRIPT_DIR/oauth_curl.py -u \"$user\" -m \"$method\" -d \"$data\" -k \"$key\" -s \"$secret\" \"$h_name$path\""
  response=`$SCRIPT_DIR/oauth_curl.py -u "$CP_USER" -m "$method" -d "$data" -k "$key" -s "$secret" "$h_name$path"`
  echo $response | json_reformat &> /dev/null

  if [ $? == 0 ]; then
    echo $response | json_reformat
  else
    echo $response
  fi
}


# Call katello api
# 1st param: relative path
# 2nd param: method
# 3rd param: data
kat-api() {
  call-api "$KAT_API_URL" "$KAT_USER:$KAT_PASSWORD" $@
}

# Call candlepin api
# 1st param: relative path
# 2nd param: method
# 3rd param: data
cp-api() {
  #call-api "$CP_API_URL" "$CP_USER:$CP_PASSWORD" $@
  call-oauth-api "$CP_API_URL" "$CP_USER" "$CP_OAUTH_KEY" "$CP_OAUTH_SECRET" $@
}

# Call pulp api
# 1st param: relative path
# 2nd param: method
# 3rd param: data
pulp-api() {
  call-api "$PULP_API_URL" "$PULP_USER:$PULP_PASSWORD" $@
}

