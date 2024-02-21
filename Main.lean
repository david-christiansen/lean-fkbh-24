import Lean
import Bob

open Lean (Json)
open Bob

def main : List String → IO UInt32
  | [q] => do
    let query ←
      match Json.parse q >>= Query.parse (ctxt := .val) with
      | .error e => IO.eprintln e; return 1
      | .ok q' => pure q'
    let input ← readStdin
    match readJsonArray input with
    | .error e => IO.eprintln e; return 3
    | .ok vals =>
      for v in Array.filter (query.matches · = true) vals do
        IO.println v
      return 0
  | _ => do
    IO.println "Usage: bob QUERY"
    return 2
