#!/usr/bin/env bash
set -euo pipefail
# Independent source check: the official text can falsify the fixed relation.
# The Bend proof is separately checked in gate.sh.
text=$(curl --fail --silent --show-error --location --max-time 20 \
  'https://www.archives.gov/publications/prologue/2015/winter/amending-america')
printf '%s' "$text" | grep -Eiq '21st Amendment repealed the 18th'
