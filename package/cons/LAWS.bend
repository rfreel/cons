import Base
import ./state.bend as State
import ./impl.bend as Impl
import ./SPEC.bend as Spec

law rejects_eighteenth_as_operative:
  {Impl.decide_operativity(State.A18{}, State.current_relation()) == Impl.RejectOperative{Spec.repealer_of_eighteenth()} : Impl.OperativityDecision}

law accepts_twenty_first_as_operative:
  {Impl.decide_operativity(State.A21{}, State.current_relation()) == Impl.AcceptOperative{} : Impl.OperativityDecision}

law preserves_eighteenth_source:
  {State.source_contains(State.A18{}) == True{} : Bool}
