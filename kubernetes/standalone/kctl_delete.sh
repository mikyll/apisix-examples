#!/bin/bash

DELETE_STRING=""
for RESOURCE in resources/*.yaml; do
  DELETE_STRING="${DELETE_STRING} -f ${RESOURCE}"
done

kubectl delete $DELETE_STRING
