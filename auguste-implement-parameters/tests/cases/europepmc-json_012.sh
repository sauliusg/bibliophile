#! /bin/sh

set -ue

PATH=tests/bin/europepmc-json_012:${PATH}

./europepmc-json tests/inputs/europepmc-json_012.inp --url-encode
