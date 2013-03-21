#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o xtrace

readonly HOST=home.adelphi.edu
# Wget creates a directory hierarchy like this. That's too deep.
readonly HOST_SUBDIR=$HOST/sbloch/class/archive/271/fall2005/examples/
readonly NEW_DIR_NAME=steven-bloch

wget --recursive "http://$HOST_SUBDIR/lexyacc/"
mv "$HOST_SUBDIR" "$NEW_DIR_NAME"
rm -r "$HOST"
