#!/bin/bash

docker run --rm -it -p 9080:9080 -p 9180:9180 -p 9443:9443 \
  -v ./conf/config.yaml:/home/apisix/apisix_src/conf/config.yaml \
  apache/apisix:custom
