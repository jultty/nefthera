open Nefthera
open Transform
open Schema

let rec flow (old_universe: universe): unit =

  print_endline (Transform.Interpreter.make_prompt old_universe) ;

  print_string " > " ;
  let words = read_line () in
  let acted_universe: universe =
    Transform.Interpreter.interpret old_universe words in

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
