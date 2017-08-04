#! /bin/sh

set -ue

PATH=tests/bin/europepmc-json_008:${PATH}

./europepmc-json tests/inputs/searchterm_solsa.inp
