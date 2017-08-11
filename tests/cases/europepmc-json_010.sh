#! /bin/sh

set -ue

PATH=tests/bin/europepmc-json_008:${PATH}

./europepmc-json --script tests/inputs/searchterm_solsa.inp
