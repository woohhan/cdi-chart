#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

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
  if [[ $(kubectl get ns | grep cdi) ]]; then sleep 10; echo 'Waiting for deleting namespace...'; fi
  if [[ $(kubectl get ns | grep cdi) ]]; then sleep 10; echo 'Waiting for deleting namespace...'; fi
  if [[ $(kubectl get ns | grep cdi) ]]; then sleep 10; echo 'Waiting for deleting namespace...'; fi
  if [[ $(kubectl get ns | grep cdi) ]]; then sleep 10; echo 'Waiting for deleting namespace...'; fi
  if [[ $(kubectl get ns | grep cdi) ]]; then sleep 10; echo 'Waiting for deleting namespace...'; fi
  if [[ $(kubectl get ns | grep cdi) ]]; then sleep 10; echo 'Waiting for deleting namespace...'; fi
  if [[ $(kubectl get ns | grep cdi) ]]; then false; fi
  kubectl get pods -A
  kubectl get ns
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
