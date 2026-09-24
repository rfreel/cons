# Reworking the constitutional law sketch

The supplied 591-line text is a Python script containing a draft notation, not a Bend file. It ranges from Articles I–VII through Amendments I–XXVII. This review treats it as a source for requirements, not as laws that already hold.

## Correct the model before translating syntax

| Draft statement | Problem | Next form |
| --- | --- | --- |
| `AMENDMENT_18: Repealed(Amendment18)` | It replaces the historical content of XVIII with its later status. | Keep an XVIII source record and its original clauses. Add a later relation from XXI §1 to XVIII with an effective time. |
| `AMENDMENT_21: Repealed(Amendment18)` | It has no provenance, time, or affected scope. | A clause-backed repeal event with source `XXI.1`, target `XVIII`, and effective date; retain the source record. |
| `Search(a) OR Seizure(a) => Reasonable(a)` | It asserts that every search or seizure is reasonable. The Fourth Amendment protects against unreasonable ones. | Model a constraint on covered government action; do not infer reasonableness from the fact of a search. |
| `Permitted(a,s) <-> exists explicit permit and no forbid` | It treats absence of an explicit permission as a negative answer and assumes all relevant authority has been loaded. | Return `Undetermined` if the available sources do not support either side. Keep authority, coverage, and conflict handling explicit. |
| `delta(s,a) = Apply(a,s)` when permitted | A decision on permission does not describe the real-world effect of an act. | Separate claim decisions from state transitions, and model transitions only when evidence and rules warrant them. |
| `Proposed(a) <-> ...` and `Ratified(a) <-> ...` | An equivalence makes the listed facts both necessary and sufficient without modeling all Article V conditions, modes, and timing. | Begin with one-way rules and separately checked source facts; add converses only when their assumptions are stated and proved. |
| `yes/cast` in vote rules | `cast=0` is undefined; some constitutional thresholds depend on those present or on the full body. | Use an explicit vote event, denominator, quorum, and a nonzero precondition for each clause. |
| `Citizen <: Person`, `Officer <: Person` | Membership and office can change with time and jurisdiction; the sketch treats them as permanent subtypes. | Use a person ID with dated citizenship and office records. |

Primary text: [XVIII](https://constitution.congress.gov/constitution/amendment-18/), [XXI](https://constitution.congress.gov/constitution/amendment-21/), [Fourth Amendment](https://constitution.congress.gov/constitution/amendment-4/), and [Article V](https://constitution.congress.gov/constitution/article-5/).

## Small Bend contract to prove first

Keep four different facts separate:

1. **Source presence:** `source_contains(A18)` is true after the repeal event.
2. **Current operation:** A18 is repealed by XXI §1; A21 remains operative within this slice.
3. **Claim decision:** A claim of current A18 operativity is rejected with the repeal clause as its reason; the corresponding A21 claim is accepted.
4. **Coverage:** A claim outside loaded sources is undetermined. No closed-world inference turns missing evidence into a rejection or permission.

A future general decision type can be `Supported(evidence)`, `Refuted(evidence)`, `Undetermined(reason)`, or `Conflict(evidence)`. Evidence should carry the exact source clause and effective time. This type is a design proposal; the current Bend API only has the fixed A18/A21 decisions.

## Proof sequence

1. Check the current concrete XVIII/XXI laws with stock Bend. Confirm deliberate always-accept and always-reject mutations fail. Compare the source relation with the independent constitutional text.
2. Define a separate, typed source store with stable source IDs and clause IDs. Prove that applying a repeal event changes operation without deleting source presence.
3. Add dated events and a claim scope. Prove that the exported decision agrees with a separate specification for every admitted input; return `Undetermined` when coverage is missing.
4. Add one constitutional clause family at a time, with a cited text, explicit assumptions, positive and negative examples, and a mutation that the law catches. Keep unresolved interpretive questions outside the checked rule set.
5. Review each claim against independent text and the actual Bend result before adding it to the frozen laws. The pasted sketch alone is not an oracle.

The current package card remains limited to XVIII/XXI. A general constitution model needs its own domain card and proof scope; expanding the existing frozen card would silently change what its checks mean.
