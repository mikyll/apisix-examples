# APISIX Authorization Plugins

This example shows how to setup and use most common authorization plugins.

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

### External Upstream (HTTPS)

Wrong method:

```bash
curl -X POST "localhost:9080/get"
```

Correct method:

```bash
curl -X GET "localhost:9080/get"
```

### Rewrite URI

```bash
curl "localhost:9080/httpbin/anything"
```

```bash
curl "localhost:9080/httpbin/ip"
```

```bash
curl "localhost:9080/httpbin/uuid"
```

### Multiple URIs

```bash
curl "localhost:9080/multiple_uris"
curl "localhost:9080/v2/multiple_uris"
curl "localhost:9080/api/multiple_uris"
```

### Hosts

No host:

```bash
curl "localhost:9080/hosts"
```

Valid host:

```bash
curl "localhost:9080/hosts" -H "Host: local.httpbin.org"
```

PAN domain host:

```bash
curl "localhost:9080/hosts" -H "Host: apisix.apache.org"
```

### Priority

There are 2 routes that matches `/priority` URI. The following test shows that the route that matches the request is the one with higher priority (`100 > 50`):

```bash
curl "localhost:9080/priority"
```

### Vars

The route is matched only if query params contain both:

- `name = joe`
- `age > 18`

Wrong vars check (`age <= 18`):

```bash
curl "localhost:9080/vars?name=joe&age=18"
```

Wrong vars check (`name != joe`):

```bash
curl "localhost:9080/vars?name=jeff&age=20"
```

Correct vars check:

```bash
curl "localhost:9080/vars?name=joe&age=20"
```

### Filter Function

The route is matched only if query params:

- contain `age`;
- `age` is a number;
- `age` is an even number;

Wrong filter_func check (missing `arg` query param):

```bash
curl "localhost:9080/filter_func"
```

Wrong filter_func check (wrong `arg` query param type):

```bash
curl "localhost:9080/filter_func?age=test"
```

Wrong filter_func check (wrong `arg` query param is odd):

```bash
curl "localhost:9080/filter_func?age=19"
```

Correct filter_func check:

```bash
curl "localhost:9080/filter_func?age=20"
```

### Timeout

Exceeding timeout:

```bash
curl "localhost:9080/delay/3"
```

Not exceeding timeout:

```bash
curl "localhost:9080/delay/1"
```

### Websocket

Test the websocket:

```bash
wscat --connect "ws://localhost:9080/websocket"
```

### Status

Test disabled route (`status = 0`):

```bash
curl "localhost:9080/status"
```

### Script

Test route with script (NB: scripts and plugins are mutually exclusive):

```bash
curl "localhost:9080/script"
```

### Path Parameters

APISIX router `radixtree_uri_with_parameter` (see [config.yaml](conf/config.yaml)) allows path parameters in route URIs. The following example matches `/path_params/:param1/foo/:param2/bar`:

```bash
curl "localhost:9080/path_params/abc123/foo/def456/bar"
```
