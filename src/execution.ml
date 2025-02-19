open Zipper
open Types

let format_state_tape (state, tape) =
  Printf.sprintf "(State: %s, Tape: %s)" state (Zipper.get_tape_str tape)
  
let print_visited visited =
  Printf.printf "Visited states and tapes:\n";
  StateTapeSet.iter (fun pair -> Printf.printf "%s\n" (format_state_tape pair)) visited

let direction_to_string = function
  | Left -> "LEFT"
  | Right -> "RIGHT"

let pad_tape tape blank padding_size =
  let padded_left = 
    if String.length tape.left < padding_size then
      String.make (padding_size - String.length tape.left) blank ^ tape.left
    else
      tape.left
  in
  let padded_right =
    if String.length tape.right < padding_size then
      tape.right ^ String.make (padding_size - String.length tape.right) blank
    else
      tape.right
  in
  { tape with left = padded_left; right = padded_right }

let check_dead_end transition state tape =
	if transition.to_state != state then
		false
	else (
		match transition.action with
		| Left -> left_is_empty tape
		| Right -> right_is_empty tape
	)


let rec execute_machine blank tape state machine visited =
  (* print_visited visited; *)
  (* Appliquer le padding à la bande avant de vérifier *)
  let padded_tape = pad_tape tape blank padding_size in
  let current_pair = (state, padded_tape) in

  (* Vérifier si la paire (state, tape) existe déjà dans visited *)
  if StateTapeSet.mem current_pair visited then
    raise (Infinite_loop "Infinite loop detected")
  else
    (* Ajouter la paire (state, tape) à visited *)
    let visited = StateTapeSet.add current_pair visited in
    
    if List.mem state machine.finals then
      tape
    else (
		(* Affichage de l'état actuel et de la bande *)
		Printf.printf "%s " (Zipper.format_tape tape blank);
		let current_char = current tape in
		(* Récupérer les transitions pour l'état courant *)
		let transitions = List.assoc state machine.transitions in
		(* Trouver la transition correspondant au symbole sous le curseur *)

    if not (List.exists (fun t -> t.read = current_char) transitions) then
      raise (Read_Not_Found "No transition found for the current symbol");
		let transition = List.find (fun t -> t.read = current_char) transitions in

		(* Écrire le nouveau symbole sur la bande *)
		let new_tape = write transition.write tape in
		(* Déplacer le curseur *)
		let new_tape = match transition.action with
			| Left -> move_left blank new_tape
			| Right -> move_right blank new_tape
		in
		(* Affichage de la transition *)
		Printf.printf "(%s, %c) -> (%s, %c, %s)\n"
			state current_char transition.to_state transition.write (direction_to_string transition.action);

		(* Check si on est pas dans une impasse *)
		if (current_char = blank && check_dead_end transition state new_tape) then
			raise (Infinite_loop "Dead end detected")
		else
		(* Appel récursif avec la nouvelle bande et l'état suivant *)
			execute_machine blank new_tape transition.to_state machine visited
    )