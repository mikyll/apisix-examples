# httpbin Helm Chart

## Setup

### Kubernetes Cluster

Start Minikube or create a Minikube cluster (with Docker driver):

```bash
minikube start --driver=docker
```

Check the current context to be "minikube":

```bash
kubectl config current-context
```

### Helm Chart

Update Helm dependencies:

```bash
helm dependency update
```

Create a template of resulting Kubernetes resources:

```bash
helm template httpbin . --debug --dry-run > debug.yaml
```

Install the Helm chart:

```bash
helm install httpbin -f values.yaml .
```

Uninstall the Helm chart:

```bash
helm uninstall httpbin
```

## Test Routes

Enable Kubernetes port-forwarding:

```bash
kubectl port-forward svc/httpbin 3000:80
```

Send a request:

```bash
curl localhost:3000/anything
```
