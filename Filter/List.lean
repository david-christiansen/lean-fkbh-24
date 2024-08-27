import Lean

namespace Filter.List

def filter (p : α → Prop) [DecidablePred p] (xs : List α) : List α := xs
