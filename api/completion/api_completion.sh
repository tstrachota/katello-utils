#!/bin/sh




function get_known_parts() {
  # $1 = file with path bits
  cat $1
}


function get_first_id() {
  known_parts=$2
  line=$1

  line_parts=`echo $line | sed 's|/| |g'`
  for part in $line_parts; do

    if [ "`echo $known_parts | grep $part`" == "" ]; then
      echo $part
      return
    fi
  done
}

function complete_api() {
  # $1 = routes file
  # $2 = file with bits

  #spocitej mozne doplneni
  #while (zadny naseptany retezec) and (v $opts jsou jeste nejake ID)
    #najdi prvni retezec mezi / /, ktery neni v $opts (prvni id)
    #nahrad prvni vyskyt ID v kazdem opt prvnim id
    #prepocitej naseptane retezce
  #vypocitej finalni compreply


  local cur opts
  COMPREPLY=()

  cur="${COMP_WORDS[COMP_CWORD]}"

  opts=`cat $1`
  known_parts=`get_known_parts $2`

  m=$(compgen -W "${opts}" -- ${cur})
  n="X"

  #while no options are matching and there are still some ID's to replace
  while ( [ "$m" == "" ] && [ "$n" != "" ] ); do

    #get first ID from the line
    firstid=`get_first_id $cur "$known_parts"`
    known_parts="$known_parts $firstid"

    #temporary variable for filtering options
    opts2=""

    #search only options starting with the same first 2 letters
    #as the current line
    possible_opts=`echo $opts | tr -s ' ' '\n' | grep ${cur:0:2}`
    for o in $possible_opts; do
      o=`echo $o | sed "s|ID|$firstid|"`
      opts2="$opts2 $o"
    done
    opts=$opts2

    #recount loop conditions
    m=$(compgen -W "${opts}" -- ${cur})
    n=`echo $opts | tr -s ' ' '\n' | grep ${cur:0:2} | grep 'ID'`
  done

  COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
  return 0
}

