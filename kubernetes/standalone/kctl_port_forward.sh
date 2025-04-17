#!/bin/bash

kubectl port-forward -n apisix svc/apisix 9080:80
