#! /bin/sh

set -ue

PATH=tests/bin/europepmc-json_014:${PATH}

./europepmc-json -s crystal -l 1 --page-size 1 
