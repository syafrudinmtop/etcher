#!/bin/bash

###
# Copyright 2016 resin.io
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###

set -u
set -e

function check_dep() {
  if ! command -v $1 2>/dev/null 1>&2; then
    echo "Dependency missing: $1" 1>&2
    exit 1
  fi
}

check_dep asar

function usage() {
  echo "Usage: $0"
  echo ""
  echo "Options"
  echo ""
  echo "    -d <directory>"
  echo "    -o <output>"
  exit 0
}

ARGV_DIRECTORY=""
ARGV_OUTPUT=""

while getopts ":d:o:" option; do
  case $option in
    d) ARGV_DIRECTORY=$OPTARG ;;
    o) ARGV_OUTPUT=$OPTARG ;;
    *) usage ;;
  esac
done

if [ -z "$ARGV_DIRECTORY" ] || [ -z "$ARGV_OUTPUT" ]; then
  usage
fi

mkdir -p $(dirname "$ARGV_OUTPUT")
asar pack "$ARGV_DIRECTORY" "$ARGV_OUTPUT" --unpack *.node