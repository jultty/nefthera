open Schema

let make_prompt (u: universe): string =
  "Grain: " ^ string_of_int u.time.grain

let interpret (old: universe) (input: string): universe =
  match input with
  | "halt" | "exit" | "quit" -> { old with time = { old.time with halt = true } }
  | _ -> old
