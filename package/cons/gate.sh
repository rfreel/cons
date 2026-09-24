#!/usr/bin/env bash
set -u
if [ "${1-}" != check ]; then exit 2; fi
cd "$(dirname "$0")" || exit 2

test "$(git hash-object pins/DOMAIN_CARD.md)" = "$(cat pins/DOMAIN_CARD.sha256)" || exit 10
test "$(git hash-object SPEC.bend)" = "$(cat pins/SPEC.sha256)" || exit 11
test "$(git hash-object LAWS.bend)" = "$(cat pins/LAWS.sha256)" || exit 12
test "$(git hash-object state.bend)" = "$(cat pins/STATE.sha256)" || exit 13
test "$(git hash-object gate.sh)" = "$(cat pins/GATE.sha256)" || exit 14
git rev-parse -q --verify 'refs/tags/cons/frozen' >/dev/null || exit 15
git diff --quiet cons/frozen -- AGENTS.md OBJECTIVE.md CORRECTNESS.md SPEC.bend state.bend LAWS.bend gate.sh docs/PIN.toml pins || exit 15

expected_version=$(sed -n 's/^bend_version = "\(.*\)"$/\1/p' docs/PIN.toml)
actual_version=$(bend --version) || exit 16
printf '%s\n' "$actual_version"
case "$actual_version" in *"$expected_version"*) ;; *) exit 16 ;; esac

bend PROOF.bend || exit 17

backup=$(mktemp) || exit 18
cp impl.bend "$backup" || exit 18
restore() { cp "$backup" impl.bend; rm -f "$backup"; }
trap restore EXIT INT TERM
for mutant in tests/mutations/*.bend; do
  [ -f "$mutant" ] || exit 18
  cp "$mutant" impl.bend || exit 18
  if bend PROOF.bend; then exit 18; fi
  cp "$backup" impl.bend || exit 18
done
restore
trap - EXIT INT TERM

for lane in proof differential mutation; do
  for test_script in tests/differentials/*.sh; do
    [ -f "$test_script" ] || exit 19
    bash "$test_script" "$lane" || exit 19
  done
done
exit 0
