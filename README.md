# Constitution vertical slice: Amendments XVIII and XXI

Purpose: test the rejection-first constitutional model on one explicit relation.

Independent source facts used as expected outcomes:

- Amendment XVIII was ratified in 1919 and later repealed by Amendment XXI.
- Amendment XXI Section 1 states that the Eighteenth Amendment is repealed.
- Repeal does not require deleting the Eighteenth Amendment from the historical Constitution.

The slice keeps three claims separate:

1. Historical presence: Amendment XVIII remains source material.
2. Operative status: Amendment XVIII is not currently operative because Amendment XXI repeals it.
3. Claim acceptance: a claim that Amendment XVIII is currently operative is rejected; the source text itself is not rejected.

Files:

- `SOURCE.bend`: source IDs and repeal relation.
- `ENGINE.bend`: relation resolution and claim decision.
- `LAWS.bend`: rejection, positive/anti-vacuity, and preservation requirements.
- `PROOF.bend`: same-named proofs expected to close by computation.

With Bend 2 installed, the intended checks are:

```sh
bend LAWS.bend --check-only
# Expected: open laws / nonzero status because laws intentionally lack proofs here.

bend PROOF.bend --check-only
# Expected: All terms check.
```

The expected outcomes above are source-derived, not generated from the engine itself. Actual Bend compilation is still required before claiming the code is type-correct.
