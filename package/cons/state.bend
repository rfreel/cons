import Base

type RuleId is Data:
  A18{}
  A21{}

type Relation is Data:
  Repeals{newer: RuleId, older: RuleId}

def current_relation() -> Relation:
  Repeals{A21{}, A18{}}

def source_contains(rule: RuleId) -> Bool:
  match rule:
    case A18{}:
      True{}
    case A21{}:
      True{}
