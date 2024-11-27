open Zipper
open Types

let rec execute_machine blank tape state machine =
  Printf.printf "%s\n" (Zipper.format_tape tape blank);

  if current tape = blank then
    tape  (* Si le curseur est sur un blanc, retourner la bande sans modification *)


  else
    let new_tape = move_right blank tape in
    execute_machine blank new_tape state machine