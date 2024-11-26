open Nefthera
open Parse
open Schema

let rec flow (past: universe): unit =

  print_endline (Interpreter.make_prompt past) ;
  print_string " > " ;

  let words = read_line () in
  let present: universe =
    Interpreter.interpret past words in

  let future = {
    present with time = {
      present.time with grain = present.time.grain + 1
    }
  } in

  if future.time.halt then
    print_endline "Time has come to an end."
  else
    flow future

let () = flow Nefthera.Schema.seed
