# remove unused images and containers
alias docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '


function docker-start {
  typeset vm=${1:-default} sts
  case $vm in
    -h|--help)
      echo $'usage: docker-start [<vm>]\n\nEnsures that the specified/default Docker VM is started\nand the environment is initialized.'
      return 0
      ;;
  esac
  sts=$(docker-machine status "$vm") || return
  [[ $sts == 'Running' ]] && echo "(Docker VM '$vm' is already running.)" || { 
    echo "-- Starting Docker VM '$vm' (\`docker-machine start "$vm"\`; this will take a while)..."; 
    docker-machine start "$vm" || return
  }
  echo "-- Setting DOCKER_* environment variables (\`eval \"\$(docker-machine env "$vm")\"\`)..."
  # Note: If the machine hasn't fully finished starting up yet from a
  #       previously launched-but-not-waited-for-completion `docker-machine status`,
  #       the following may output error messages; alas, without signaling failure
  #       via the exit code. Simply rerun this function to retry.
  eval "$(docker-machine env "$vm")" || return
  export | grep -o 'DOCKER_.*'
  echo "-- Docker VM '$vm' is running."
}


function docker-stop {
  typeset vm=${1:-default} sts envVarNames fndx
  case $vm in
    -h|--help)
      echo $'usage: docker-stop [<vm>]\n\nEnsures that the specified/default Docker VM is stopped\nand the environment is cleaned up.'
      return 0
      ;;
  esac
  sts=$(docker-machine status "$vm") || return
  [[ $sts == 'Running' ]] && { 
    echo "-- Stopping Docker VM '$vm' (\`docker-machine stop "$vm"\`)...";
    docker-machine stop "$vm" || return
  } || echo "(Docker VM '$vm' is not running.)"
  [[ -n $BASH_VERSION ]] && fndx=3 || fndx=1 # Bash prefixes defs. wit 'declare -x '
  envVarNames=( $(export | awk -v fndx="$fndx" '$fndx ~ /^DOCKER_/ { sub(/=.*/,"", $fndx); print $fndx }') )
  if [[ -n $envVarNames ]]; then
    echo "-- Unsetting DOCKER_* environment variables ($(echo "${envVarNames[@]}" | sed 's/ /, /g'))..."
    unset "${envVarNames[@]}"
  else
    echo "(No DOCKER_* environment variables to unset.)"
  fi
  echo "-- Docker VM '$vm' is stopped."
}
