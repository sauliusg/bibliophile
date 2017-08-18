#! /bin/sh

set -ue

./europepmc-json \
    --page-size 2 \
    --progress \
    --search IND601311758+OR+IND601311566+OR+IND601309362+OR+IND601309237 \
| jq -r '.resultList.result[] | .id' \
| sort
