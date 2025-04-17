# APISIX Kubernetes Standalone

This example shows a simple APISIX setup in Kubernetes (without Helm), using Standalone deployment mode. In this mode, APISIX resources are configured by using a YAML file `apisix.yaml` mounted via a ConfigMap: [`cm-resources.yaml](resources/cm-resources.yaml).

## Setup

Start a Kubernetes cluster. For example, you can use minikube:

```bash
minikube start
```

Create Kubernetes resources and deploy APISIX:

```bash
./kctl_apply.sh
```

## Watch Logs

To watch APISIX logs you can run the following script:

```bash
./kctl_watch_logs.sh
```

## Port Forward

To make APISIX listen on localhost:9080, you can run the following script:

```bash
./kctl_port_forward.sh
```

## Test Routes

### Base Route

```bash
curl -i "localhost:9080/anything"
```
