import Base

# Minimal source identity for this vertical slice.
type RuleId is Data:
  A18{}
  A21{}

# A source relation does not delete either rule.
type Relation is Data:
  Repeals{newer: RuleId, older: RuleId}

# Twenty-First Amendment, Section 1 -> repeals Eighteenth Amendment.
def current_relation() -> Relation:
  Repeals{A21{}, A18{}}

# Historical presence is separate from operative status.
def source_contains(rule: RuleId) -> Bool:
  match rule:
    case A18{}:
      True{}
    case A21{}:
      True{}
