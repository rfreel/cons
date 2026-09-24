import Base
import ./state.bend as State

type Status is Data:
  Operative{}
  Repealed{by: State.RuleId}

type OperativityDecision is Data:
  AcceptOperative{}
  RejectOperative{by: State.RuleId}

def status_under(rule: State.RuleId, relation: State.Relation) -> Status:
  match relation:
    case State.Repeals{newer, older}:
      match rule:
        case State.A18{}:
          match older:
            case State.A18{}:
              Repealed{newer}
            case State.A21{}:
              Operative{}
        case State.A21{}:
          match older:
            case State.A18{}:
              Operative{}
            case State.A21{}:
              Repealed{newer}

def decide_from_status(status: Status) -> OperativityDecision:
  match status:
    case Operative{}:
      AcceptOperative{}
    case Repealed{by}:
      RejectOperative{by}

def decide_operativity(rule: State.RuleId, relation: State.Relation) -> OperativityDecision:
  decide_from_status(status_under(rule, relation))
