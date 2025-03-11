# APISIX Docker Traditional

This example shows a simple APISIX setup in Docker, using Traditional deployment mode. In this mode, APISIX resources are configured by sending HTTP requests to Admin API.

## Setup

Start APISIX in Docker by running the following command:

```bash
docker compose up
```

Run the following script to create some simple test resources (Upstreams, Consumers, Routes):

```bash
./create_resources.sh
```

## Show Resources

Run the following script to show APISIX resources (Upstreams, Consumers, Routes):

```bash
./get_resources.sh
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

## Delete Resources

Run the following script to delete APISIX resources (Upstreams, Consumers, Routes):

```bash
./delete_resources.sh
```
