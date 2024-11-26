open Nefthera
open Parse
open Schema

let put = print_string
let putl = print_endline

let rec flow (past: universe): unit =

  putl (Interpreter.make_prompt past) ;
  put " > " ;

  let words = read_line () in
  let present: universe =
    Interpreter.interpret past words in

  let future = {
    present with time = {
      present.time with grain = present.time.grain + 1
    }
  } in

  if future.time.halt then
    putl @@ future.player.name ^ ", " ^ future.player.title
      ^ ", your time has come to a halt."
  else
    flow future

let () = flow Nefthera.Schema.seed
