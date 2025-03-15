<div align="center">

[![APISIX][apisix-shield]][apisix-url]
[![NGINX][nginx-shield]][nginx-url]
[![Lua][lua-shield]][lua-url]
[![Perl][perl-shield]][perl-url]
[![YAML][yaml-shield]][yaml-url]

# APISIX Examples

APISIX examples for different setups, configurations and plugins usage.

[APISIX Source](https://github.com/apache/apisix)
·
[APISIX Docs](https://apisix.apache.org/)
|
[Deployment Modes](https://apisix.apache.org/docs/apisix/deployment-modes/)
|
[Admin API](https://apisix.apache.org/docs/apisix/admin-api/)
|
[Plugin Develop](https://apisix.apache.org/docs/apisix/plugin-develop/)

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

#### APISIX Control API

Folder: [`misc/apisix_control_api/`](misc/apisix_control_api/README.md)

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

#### Replace Builtin Plugin

Folder: [`misc/plugin_replace_builtin/`](misc/plugin_replace_builtin/README.md)

<!-- GitHub Shields -->

[apisix-shield]: https://custom-icon-badges.demolab.com/badge/APISIX-grey.svg?logo=apisix_logo
[apisix-url]: https://apisix.apache.org/
[nginx-shield]: https://img.shields.io/badge/NGiNX-%23009639.svg?logo=nginx
[nginx-url]: https://nginx.org/en/
[lua-shield]: https://img.shields.io/badge/Lua-%232C2D72.svg?logo=lua&logoColor=white
[lua-url]: https://www.lua.org/
[perl-shield]: https://img.shields.io/badge/Perl-%2339457E.svg?logo=perl&logoColor=white
[perl-url]: https://www.perl.org/
[yaml-shield]: https://img.shields.io/badge/YAML-%23ffffff.svg?logo=yaml&logoColor=151515
[yaml-url]: https://yaml.org/