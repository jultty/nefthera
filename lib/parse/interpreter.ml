open Schema

let make_prompt (u: universe): string =
    "[ Grain: " ^ string_of_int u.time.grain ^ " ]"

let interpret (past: universe) (words: string): universe =

  let future = {
    past with
    meta = { message = "" };
    time = { past.time with grain = past.time.grain + 1 }
  } in

  match words with
    | "halt" | "exit" | "quit" -> {
      future with time = { future.time with halt = true }
    }
    | "help" -> {
      future with meta = { message = "Glad you asked" }
    }
    | _ -> future
