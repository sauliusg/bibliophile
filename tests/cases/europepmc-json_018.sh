#! /bin/sh

set -ue

./europepmc-json \
    --search IND601311758+OR+IND601311566+OR+IND601309362+OR+IND601309237 \
    --json-output \
    --idlist  \
| jq . \
| grep -v nextCursorMark \
| sort
