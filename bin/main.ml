open Nefthera.Schema

let rec flow (old_universe: universe): unit =

  print_endline (Nefthera.Interpreter.make_prompt old_universe) ;

  print_string " > " ;
  let words = read_line () in
  let acted_universe: universe =
    Nefthera.Interpreter.interpret old_universe words in

  let next_time = acted_universe.time.grain + 1 in
  let next_universe = {
    acted_universe with time = {
      acted_universe.time with grain = next_time
    }
  } in

  if next_universe.time.halt then
    print_endline "Time has come to an end."
  else
    flow next_universe

let () = flow Nefthera.Schema.seed
