# containerized-data-importer Helm Chart ![cdi-chart](https://github.com/woohhan/cdi-chart/workflows/e2e/badge.svg)
A Helm chart for [kubevirt/containerized-data-importer](https://github.com/kubevirt/containerized-data-importer)

## Quick Start
1. Install Helm(>3.0): [Installing Helm](https://helm.sh/docs/intro/install/)
2. Check `init/values.yaml`, `core/values.yaml` files
3. Install cdi-init: `helm template init | kubectl apply -f -`
4. Install cdi-core: `helm template core | kubectl apply -f -`

## Uninstall
1. Uninstall cdi-core: `helm template core | kubectl delete -f -`
2. Uninstall cdi-init: `helm template init | kubectl delete -f -`
