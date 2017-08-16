#! /bin/sh

set -ue

./europepmc-xml \
    --search IND601311758+OR+IND601311566+OR+IND601309362+OR+IND601309237 \
| perl -lne 'print $1 while /<id>(.*?)<\/id>/g' \
| sort
