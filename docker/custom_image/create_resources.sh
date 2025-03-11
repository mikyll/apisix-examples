#!/bin/bash

ADMIN_APIKEY="1a8fe9bd-73ab-493c-ac82-44db40eab641"

# Upstreams
# Upstream to internal service
curl -s -i -X PUT "http://localhost:9180/apisix/admin/upstreams/internal_httpbin" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "nodes": {
    "httpbin-custom:80": 1
  },
  "type": "roundrobin"
}'

# Routes
# Simple route to internal service
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/base_internal" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/anything",
  "upstream_id": "internal_httpbin"
}'
