open Schema

let make_prompt (u: universe): string =
  "Grain: " ^ string_of_int u.time.grain

let interpret (u: universe) (words: string): universe =
  match words with
  | "halt" | "exit" | "quit" -> {
    u with time = { u.time with halt = true }
  }
  | _ -> u
