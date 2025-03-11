#!/bin/bash

ADMIN_APIKEY="1a8fe9bd-73ab-493c-ac82-44db40eab641"

# Upstreams
# Upstream to internal service
curl -s -i -X PUT "http://localhost:9180/apisix/admin/upstreams/internal_httpbin" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "nodes": {
    "httpbin-traditional-generic:80": 1
  },
  "type": "roundrobin"
}'

# Upstream to internal service echo
curl -s -i -X PUT "http://localhost:9180/apisix/admin/upstreams/internal_echo" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "nodes": {
    "echo-traditional-generic:8080": 1
  },
  "type": "roundrobin"
}'

# Upstream to external service
curl -s -i -X PUT "http://localhost:9180/apisix/admin/upstreams/external_httpbin" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "scheme": "https",
  "nodes": {
    "httpbin.org": 1
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

# Simple route to external service
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/base_external" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/get",
  "upstream_id": "external_httpbin",
  "methods": [
    "GET"
  ]
}'

# Rewrite URI
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/httpbin_internal" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/httpbin/*",
  "upstream_id": "internal_httpbin",
  "plugins": {
    "proxy-rewrite": {
      "regex_uri": [
        "^/httpbin/(.*)",
        "/$1"
      ]
    }
  }
}'

# Methods
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/methods" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/methods",
  "upstream_id": "internal_httpbin",
  "methods": [
    "PUT"
  ],
  "plugins": {
    "proxy-rewrite": {
      "uri": "/anything"
    }
  }
}'

# Multiple uris
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/multiple_uris" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uris": [
    "/multiple_uris",
    "/v2/multiple_uris",
    "/api/multiple_uris"
  ],
  "upstream_id": "internal_httpbin",
  "plugins": {
    "proxy-rewrite": {
      "uri": "/anything"
    }
  }
}'

# Hosts
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/hosts" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/hosts",
  "upstream_id": "internal_httpbin",
  "hosts": [
    "local.httpbin.org",
    "*.apache.org"
  ],
  "plugins": {
    "proxy-rewrite": {
      "uri": "/anything"
    }
  }
}'

# priority (2 routes with same uri but different priority)
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/priority1" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/priority",
  "upstream_id": "internal_httpbin",
  "priority": 100,
  "plugins": {
    "proxy-rewrite": {
      "uri": "/anything?priority=100"
    }
  }
}'
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/priority2" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/priority",
  "upstream_id": "internal_httpbin",
  "priority": 50,
  "plugins": {
    "proxy-rewrite": {
      "uri": "/anything?priority=50"
    }
  }
}'

# vars (https://nginx.org/en/docs/http/ngx_http_core_module.html#variables)
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/vars" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/vars",
  "upstream_id": "internal_httpbin",
  "vars": [
    [
      "AND",
      [ "arg_name", "==", "joe" ],
      [ "arg_age", ">", "18" ]
    ]
  ],
  "plugins": {
    "proxy-rewrite": {
      "uri": "/anything"
    }
  }
}'

# filter_func
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/filter_func" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/filter_func",
  "upstream_id": "internal_httpbin",
  "filter_func": "function(vars); local age = tonumber(vars.arg_age); return age and age % 2 == 0; end",
  "plugins": {
    "proxy-rewrite": {
      "uri": "/anything"
    }
  }
}'

# timeout
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/timeout" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/timeout/*",
  "upstream_id": "internal_httpbin",
  "timeout": {
    "connect": 2,
    "send": 2,
    "read": 2
  },
  "plugins": {
    "proxy-rewrite": {
      "regex_uri": [
        "^/timeout/(.*)",
        "/delay/$1"
      ]
    }
  }
}'

# websocket
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/websocket" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/websocket",
  "upstream_id": "internal_echo",
  "enable_websocket": true,
  "plugins": {
    "proxy-rewrite": {
      "uri": "/.ws"
    }
  }
}'

# script
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/script" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/script",
  "upstream_id": "internal_httpbin",
  "script": "local _M = {}; function _M.access(conf, ctx); ngx.say([[{\"msg\":\"Hello from route script\"}]]); end; return _M"
}'

# status
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/status" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/status",
  "upstream_id": "internal_httpbin",
  "status": 0,
  "plugins": {
    "proxy-rewrite": {
      "uri": "/anything"
    }
  }
}'

# path parameters
curl -s -i -X PUT "http://localhost:9180/apisix/admin/routes/path_params" -H "X-API-KEY: $ADMIN_APIKEY" -d '
{
  "uri": "/path_params/:param1/foo/:param2/bar",
  "upstream_id": "internal_httpbin",
  "plugins": {
    "proxy-rewrite": {
      "regex_uri": [
        "^/path_params/(.*)/foo/(.*)/bar",
        "/anything?param1=$1&param2=$2"
      ]
    }
  }
}'
