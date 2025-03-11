#!/bin/bash

ADMIN_APIKEY="1a8fe9bd-73ab-493c-ac82-44db40eab641"
PRINT_RESOURCES=0

# Check if jq is installed
echo '{}' | jq '.' >/dev/null
if [[ $? -ne 0 ]]; then
  echo "jq command not found"
  exit 1
fi

# Retrieve the list of upstreams
UPSTREAMS=$(curl -s "http://localhost:9180/apisix/admin/upstreams" -H "X-API-KEY: $ADMIN_APIKEY" |
  jq -r '.list.[].value.id')

# Retrieve the list of consumers
CONSUMERS=$(curl -s "http://localhost:9180/apisix/admin/consumers" -H "X-API-KEY: $ADMIN_APIKEY" |
  jq -r '.list.[].value.username')

# Retrieve the list of routes
ROUTES=$(curl -s "http://localhost:9180/apisix/admin/routes" -H "X-API-KEY: $ADMIN_APIKEY" |
  jq -r '.list.[].value.id')

# Print lists
if [[ $PRINT_RESOURCES -eq 1 ]]; then
  echo "Upstreams:"
  echo "$UPSTREAMS"
  echo ""
  echo "Consumers:"
  echo "$CONSUMERS"
  echo ""
  echo "Routes:"
  echo "$ROUTES"
  echo ""
fi

UPSTREAMS=$(echo "$UPSTREAMS" | tr '\n' ' ')
CONSUMERS=$(echo "$CONSUMERS" | tr '\n' ' ')
ROUTES=$(echo "$ROUTES" | tr '\n' ' ')

# Delete resources
for ROUTE in $ROUTES; do
  echo "Deleting route ${ROUTE}"
  curl -s -X DELETE "http://localhost:9180/apisix/admin/routes/${ROUTE}" -H "X-API-KEY: $ADMIN_APIKEY"
done

for CONSUMER in $CONSUMERS; do
  echo "Deleting consumer ${CONSUMER}"
  curl -s -X DELETE "http://localhost:9180/apisix/admin/consumers/${CONSUMER}" -H "X-API-KEY: $ADMIN_APIKEY"
done

for UPSTREAM in $UPSTREAMS; do
  echo "Deleting upstream ${UPSTREAM}"
  curl -s -X DELETE "http://localhost:9180/apisix/admin/upstreams/${UPSTREAM}" -H "X-API-KEY: $ADMIN_APIKEY"
done
