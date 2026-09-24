import Base
import ./SOURCE.bend as Source

# Status answers whether a source rule currently controls in this slice.
type Status is Data:
  Operative{}
  Repealed{by: Source.RuleId}

# A claim about operativity can be accepted or rejected for a stated reason.
type OperativityDecision is Data:
  AcceptOperative{}
  RejectOperative{by: Source.RuleId}

# Resolve one repeal relation over the two-rule vertical slice.
# This is deliberately small: it demonstrates relation semantics before
# generalizing to an arbitrary relation graph.
def status_under(rule: Source.RuleId, relation: Source.Relation) -> Status:
  match relation:
    case Source.Repeals{newer, older}:
      match rule:
        case Source.A18{}:
          match older:
            case Source.A18{}:
              Repealed{newer}
            case Source.A21{}:
              Operative{}
        case Source.A21{}:
          match older:
            case Source.A18{}:
              Operative{}
            case Source.A21{}:
              Repealed{newer}

# Bend matches parameters rather than computed expressions, so resolution
# and classification are separate definitions.
def decide_from_status(status: Status) -> OperativityDecision:
  match status:
    case Operative{}:
      AcceptOperative{}
    case Repealed{by}:
      RejectOperative{by}

# Rejection occurs at the claim boundary, not at the source-text boundary.
def decide_operativity(rule: Source.RuleId, relation: Source.Relation) -> OperativityDecision:
  decide_from_status(status_under(rule, relation))
