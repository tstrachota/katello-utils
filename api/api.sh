#!/bin/sh

. ~/Scripts/katello/katello_config.sh

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
    echo "curl -H \"Content-Type: application/json\" -H \"Accept: application/json\" -# $method -d "$data" -k -u $usr_psswd $h_name$path"
    response=`curl -H "Content-Type: application/json" -H "Accept: application/json" -# $method -d "$data" -k -u $usr_psswd $h_name$path`
  else
    echo "curl -H \"Content-Type: application/json\" -H \"Accept: application/json\" -# $method -k -u $usr_psswd $h_name$path"
    response=`curl -H "Content-Type: application/json" -H "Accept: application/json" -# $method -k -u $usr_psswd $h_name$path`
  fi
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
  call-api "$KAT_HOST/api/" "$KAT_USER:$KAT_PASSWORD" $@
}

# Call candlepin api
# 1st param: relative path
# 2nd param: method
# 3rd param: data
cp-api() {
  call-api "$CP_HOST/candlepin" "$CP_USER:$CP_PASSWORD" $@
}

# Call pulp api
# 1st param: relative path
# 2nd param: method
# 3rd param: data
pulp-api() {
  call-api "$PULP_HOST/pulp/api/" "$PULP_USER:$PULP_PASSWORD" $@
}

