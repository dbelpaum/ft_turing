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

let rec execute_machine blank tape state machine visited =
  (* Vérifier si la paire (state, tape) existe déjà dans visited *)
  print_visited visited;
  let current_pair = (state, tape) in
  if StateTapeSet.mem current_pair visited then
    failwith "Boucle infinie détectée !"
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
      
      (* Appel récursif avec la nouvelle bande et l'état suivant *)
      execute_machine blank new_tape transition.to_state machine visited
    )