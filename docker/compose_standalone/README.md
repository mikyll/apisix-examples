# APISIX Docker Standalone

This example shows a simple APISIX setup in Docker, using Standalone deployment mode. In this mode, APISIX resources are configured by using a YAML file: [`apisix.yaml`](conf/apisix.yaml).

## Setup

Start APISIX in Docker by running the following command:

```bash
docker compose up
```

## Test Routes

### Base Route

```bash
curl -i "localhost:9080/anything"
```

### Proxy-rewrite Route

This route rewrites the request URL (removing the leading `/httpbin`) before forwarding it to the upstream:

```bash
curl "localhost:9080/httpbin/anything"
```
