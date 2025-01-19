open Nefthera
open Parse
open Schema

let put = print_string
let putl = print_endline

let rec flow (past: universe): unit =

  if past.meta.message <> "" then putl past.meta.message ;
  putl (Interpreter.make_prompt past) ;
  put " > " ;

  let words = read_line () in
  let future: universe =
    Interpreter.interpret past words in

  if future.time.halt then
    putl @@ future.player.name ^ ", " ^ future.player.title
      ^ ", your encounter with Time has come to a halt."
  else
    flow future

let () = flow Nefthera.Schema.seed
