#!/usr/bin/env bash
set -euo pipefail
# Independent source check: the official text can falsify the fixed relation.
# The Bend proof is separately checked in gate.sh.
text=$(curl --fail --silent --show-error --location --max-time 20 \
  'https://constitution.congress.gov/constitution/amendment-21/')
printf '%s' "$text" | grep -Eiq 'eighteenth article of amendment.*hereby repealed'
