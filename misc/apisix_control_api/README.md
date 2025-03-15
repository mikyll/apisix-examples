# APISIX Control API

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

### APISIX JSON Schema

The following API returns a huge JSON representing all information about the APISIX instance:

```bash
curl -s "localhost:9090/v1/schema" | jq
```

### Healthcheck

```bash
curl -s "localhost:9090/v1/healthcheck" | jq
```

Also accessible via browser: [localhost:9090/v1/healthcheck](http://localhost:9090/v1/healthcheck)

### Garbage Collector

The following API triggers a full garbage collection in the HTTP sybsystem

```bash
curl -s -i -X POST "localhost:9090/v1/gc"
```

### Routes

Get routes list:

```bash
curl -s "localhost:9090/v1/routes" | jq
```

Get a single route:

```bash
curl -s "localhost:9090/v1/route/httpbin_internal_route" | jq
```

### Services

Get services list:

```bash
curl -s "localhost:9090/v1/services" | jq
```

Get a single service:

```bash
curl -s "localhost:9090/v1/service/httpbin_internal_service" | jq
```

### Upstreams

Get upstreams list:

```bash
curl -s "localhost:9090/v1/upstreams" | jq
```

Get a single upstream:

```bash
curl -s "localhost:9090/v1/upstream/httpbin_internal_upstream" | jq
```

### Plugin Metadata

Get all plugin metadata:

```bash
curl -s "localhost:9090/v1/plugin_metadatas" | jq
```

Get metadata of a single plugin:

```bash
curl -s "localhost:9090/v1/plugin_metadata/file-logger" | jq
```

### Reload Plugins

The following API triggers a hot reload of all loaded plugins:

```bash
curl -s -i -X PUT "localhost:9090/v1/plugins/reload"
```
