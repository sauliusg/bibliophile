#! /bin/sh

set -ue

./europepmc-json \
    --search IND601311758+OR+IND601311566+OR+IND601309362+OR+IND601309237 \
| tail -n +4 \
| jq -r '.resultList.result[] | .id' \
| sort
