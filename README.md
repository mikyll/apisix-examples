<div align="center">

# APISIX Examples

APISIX examples for different setups, configurations and plugins usage.

</div>

## Prerequisites

- `curl`
- `wscat`
- `jq`
- `docker`
- `kubectl`
- `helm`

> [!TIP]
> To test Kubernetes examples locally, you must have a local Kubernetes cluster. I personally use [minikube](https://minikube.sigs.k8s.io/).

## Examples

### Docker

#### Compose Traditional

Folder: [`docker/compose_traditional/`](docker/compose_traditional/README.md)

#### Compose Decoupled

Folder: [`docker/compose_decoupled/`](docker/compose_decoupled/README.md)

#### Compose Standalone

Folder: [`docker/compose_standalone/`](docker/compose_standalone/README.md)

#### Custom Image

Folder: [`docker/custom_image/`](docker/custom_image/README.md)

### Kubernetes

#### Helm Chart `bitnami/apisix`

Folder: [`kubernetes/helm_apisix/`](kubernetes/helm_apisix/README.md)

TODO

#### Helm Chart `apisix/apisix`

Folder: [`kubernetes/helm_bitnami/`](kubernetes/helm_bitnami/README.md)

TODO

### Miscellaneous

#### APISIX Dashboard

Folder: [`misc/apisix_dashboard/`](misc/apisix_dashboard/README.md)

#### Generic (Standalone)

Folder: [`misc/generic/`](misc/generic/README.md)

#### Generic Traditional

Folder: [`misc/generic_traditional/`](misc/generic_traditional/README.md)

#### Etcd Snapshot

Folder: [`misc/etcd_snapshot/`](misc/etcd_snapshot/README.md)

TODO

#### Plugin Authentication

Folder: [`misc/plugin_authentication/`](misc/plugin_authentication/README.md)

#### Plugin Authorization

Folder: [`misc/plugin_authorization/`](misc/plugin_authorization/README.md)
