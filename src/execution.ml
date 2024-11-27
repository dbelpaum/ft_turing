open Zipper
open Machine

let rec execute_machine blank tape state machine =
  Printf.printf "%s" (Zipper.format_tape tape blank);

  if current tape = blank then
    tape  (* Si le curseur est sur un blanc, retourner la bande sans modification *)


  else
    let symbol = current tape;
    let transitions = match List.assoc_opt state machine.transitions with
      | Some(transitions) -> transitions
      | None -> failwith "État non trouvé dans les transitions"
    execute_machine blank new_tape  state machine  (* Appel récursif avec le nouveau tape *)
