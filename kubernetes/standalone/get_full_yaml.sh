#!/bin/bash

MERGED_YAML=""
for RESOURCE in resources/*.yaml; do
  MERGED_YAML="${MERGED_YAML}
---
$(cat "$RESOURCE")"
done

MERGED_YAML="${MERGED_YAML}
---"

echo "$MERGED_YAML"
