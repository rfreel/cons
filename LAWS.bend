import Base
import ./SOURCE.bend as Source
import ./ENGINE.bend as Engine

# REJECTION LAW:
# A claim that the Eighteenth Amendment is currently operative must be
# rejected because the Twenty-First Amendment repeals it.
law rejects_eighteenth_as_operative:
  {Engine.decide_operativity(Source.A18{}, Source.current_relation()) == Engine.RejectOperative{Source.A21{}} : Engine.OperativityDecision}

# ANTI-VACUITY / POSITIVE LAW:
# The engine may not satisfy rejection laws by rejecting every claim.
# Under this relation, the Twenty-First Amendment remains operative.
law accepts_twenty_first_as_operative:
  {Engine.decide_operativity(Source.A21{}, Source.current_relation()) == Engine.AcceptOperative{} : Engine.OperativityDecision}

# PRESERVATION LAW:
# Repeal changes operative status; it does not erase the historical source.
law preserves_eighteenth_source:
  {Source.source_contains(Source.A18{}) == True{} : Bool}
