#!/bin/bash

FLUSH_ETCD=0
TEST_PATH="${APISIX_SOURCE_DIR}/t/custom/"

usage() {
  echo "Usage: $0 [-t test-path] [-f flush-etcd]"
  echo "  -t, --test-path    Path to the test files (default: ${APISIX_SOURCE_DIR}/t/custom/)"
  echo "  -f, --flush-etcd   Flush etcd (default false)"
  exit 1
}

while getopts ":t:f" opt; do
  case ${opt} in
    t )
      TEST_PATH=$OPTARG
      ;;
    f )
      FLUSH_ETCD=1
      ;;
    \? )
      usage
      ;;
    : )
      echo "Invalid option: -$OPTARG requires an argument."
      usage
      ;;
  esac
done

shift $((OPTIND -1))

if [ -z "$APISIX_SOURCE_DIR" ]; then
  echo "APISIX_SOURCE_DIR is not set. Please set it before running the script."
  exit 1
fi

export FLUSH_ETCD
export TEST_NGINX_BINARY="/usr/local/openresty/nginx/sbin/nginx"
export APISIX_TEST_CONFIG_FILE="config-test.yaml"

cd "${APISIX_SOURCE_DIR}"

prove -I"${APISIX_SOURCE_DIR}" -I"${APISIX_SOURCE_DIR}/test-nginx/lib" -r "${TEST_PATH}"