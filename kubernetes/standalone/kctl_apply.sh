#!/bin/bash

kubectl apply -f resources/ns.yaml

APPLY_STRING=""
for RESOURCE in resources/*.yaml; do
  APPLY_STRING="${APPLY_STRING} -f ${RESOURCE}"
done

kubectl apply $APPLY_STRING
