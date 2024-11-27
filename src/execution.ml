open Zipper
open Types

let direction_to_string = function
  | Left -> "LEFT"
  | Right -> "RIGHT"

let rec execute_machine blank tape state machine =
  if List.mem state machine.finals then
    tape
  else (
    Printf.printf "%s " (Zipper.format_tape tape blank);
    let current_char = current tape in
    (* On recupere chaque transition possible de notre etat *)
    let transitions = List.assoc state machine.transitions in
    (* On recupere la transition correspondante pour le symbole sur le curseur *)
    let transition = List.find (fun t -> t.read = current_char) transitions in
    (* On ecrit le nouveau symbole *)
    let new_tape = write transition.write tape in
    (* On deplace le curseur *)
    let new_tape = match transition.action with
      | Left -> move_left blank new_tape
      | Right -> move_right blank new_tape
    in (
    Printf.printf "(%s, %c) -> (%s, %c, %s)\n"
      state current_char transition.to_state transition.write (direction_to_string transition.action);
    execute_machine blank new_tape transition.to_state machine
    )
  )