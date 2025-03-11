#!/bin/bash

ADMIN_APIKEY="1a8fe9bd-73ab-493c-ac82-44db40eab641"

# Check if jq is installed
echo '{}' | jq '.' >/dev/null
if [[ $? -ne 0 ]]; then
  echo "jq command not found"
  exit 1
fi

# Retrieve the list of upstreams
echo "Upstreams:"
curl -s "http://localhost:9180/apisix/admin/upstreams" -H "X-API-KEY: $ADMIN_APIKEY" |
  jq -r '.list.[].value | "- \(.id): \(.nodes | keys)"'
echo ""

# Retrieve the list of consumers
echo "Consumers:"
curl -s "http://localhost:9180/apisix/admin/consumers" -H "X-API-KEY: $ADMIN_APIKEY" |
  jq -r '.list.[].value | "- \(.username): \(.plugins | keys[0])"'
echo ""

# Retrieve the list of routes
echo "Routes:"
curl -s "http://localhost:9180/apisix/admin/routes" -H "X-API-KEY: $ADMIN_APIKEY" |
  jq -r '.list.[].value | if .uri then "- \(.uri)" 
         else "- \(.uris[]) " end'
echo ""
