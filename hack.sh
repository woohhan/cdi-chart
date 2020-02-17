#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

function wait_condition {
  cond=$1
  timeout=$2

  for ((i=0; i<timeout; i+=5)) do
    echo "Waiting for ${i}s condition: \"$cond\""
    if eval $cond > /dev/null 2>&1; then echo "Conditon met"; return 0; fi;
    sleep 5
  done

  echo "Condition timeout"
  return 1
}

function install {
  helm install cdi .
  sleep 30
  echo 'Waiting for deployment...'
  kubectl wait --for=condition=available deployment cdi-apiserver --timeout=30s -n cdi
  kubectl wait --for=condition=available deployment cdi-deployment --timeout=30s -n cdi
  kubectl wait --for=condition=available deployment cdi-operator --timeout=30s -n cdi
  kubectl wait --for=condition=available deployment cdi-uploadproxy --timeout=30s -n cdi
  kubectl get pods -A
}

function uninstall {
  helm uninstall cdi
  wait_condition "! kubectl get ns | grep cdi" 180 
}

case "${1:-}" in
i)
  install
  ;;
u)
  uninstall
  ;;
t)
  helm template .
  ;;
*)
  echo "usage:" >&2
  echo "  $0 i install" >&2
  echo "  $0 u uninstall" >&2
  echo "  $0 t template" >&2
  ;;
esac
