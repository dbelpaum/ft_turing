open Zipper
open Types

let direction_to_string = function
  | Left -> "LEFT"
  | Right -> "RIGHT"

let rec execute_machine blank tape state machine =
  Printf.printf "%s " (Zipper.format_tape tape blank);
  (* (scanright, 1) -> (scanright, 1, RIGHT) *)


  let current_char = current tape in
  let transitions = List.assoc state machine.transitions in
  let transition = List.find (fun t -> t.read = current_char) transitions in
  let new_tape = write transition.write tape in
  let new_tape = match transition.action with
    | Left -> move_left blank new_tape
    | Right -> move_right blank new_tape
  in
  let () = Printf.printf "(%s, %c) -> (%s, %c, %s)\n"
    state current_char transition.to_state transition.write (direction_to_string transition.action) in
  execute_machine blank new_tape transition.to_state machine