import Base
import ./state.bend as State

type Status is Data:
  Operative{}
  Repealed{by: State.RuleId}

type OperativityDecision is Data:
  AcceptOperative{}
  RejectOperative{by: State.RuleId}

def status_for_a18(newer: State.RuleId, older: State.RuleId) -> Status:
  match older:
    case State.A18{}:
      Operative{}
    case State.A21{}:
      Operative{}

def status_for_a21(newer: State.RuleId, older: State.RuleId) -> Status:
  match older:
    case State.A18{}:
      Operative{}
    case State.A21{}:
      Repealed{newer}

def status_for_rule(rule: State.RuleId, newer: State.RuleId, older: State.RuleId) -> Status:
  match rule:
    case State.A18{}:
      status_for_a18(newer, older)
    case State.A21{}:
      status_for_a21(newer, older)

def status_under(rule: State.RuleId, relation: State.Relation) -> Status:
  match relation:
    case State.Repeals{newer, older}:
      status_for_rule(rule, newer, older)

def decide_from_status(status: Status) -> OperativityDecision:
  match status:
    case Operative{}:
      AcceptOperative{}
    case Repealed{by}:
      RejectOperative{by}

def decide_operativity(rule: State.RuleId, relation: State.Relation) -> OperativityDecision:
  decide_from_status(status_under(rule, relation))
