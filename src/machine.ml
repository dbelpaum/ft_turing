open Yojson.Basic.Util

type transition = {
  read: string;
  to_state: string;
  write: string;
  action: string;
}

type turing_machine = {
  name: string;
  alphabet: string list;
  blank: string;
  states: string list;
  initial: string;
  finals: string list;
  transitions: (string * transition list) list;
}

let print_machine machine =
    let print_list label lst =
      Printf.printf "%s: [ %s ]\n" label (String.concat ", " lst)
    in

    let print_frame label =
      let width = 80 in
      let border = String.make width '*' in
      let spacer = 
        let padding = String.make (width - 2) ' ' in  (* Crée une ligne avec `width - 2` espaces *)
        "*" ^ padding ^ "*"  (* Concatène le * de chaque côté de la chaîne d'espaces *)
      in
      let total_padding = width - String.length label - 2 in
      let left_padding = total_padding / 2 in
      let right_padding = total_padding - left_padding in
      let padding_left = String.make left_padding ' ' in
      let padding_right = String.make right_padding ' ' in
      Printf.printf "%s\n%s\n*%s%s%s*\n%s\n%s\n" border spacer padding_left label padding_right spacer border    
    in

    (* Affichage de l'encadré principal avec le nom de la machine *)
    print_frame machine.name;
	
		print_list "Alphabet" machine.alphabet;
		print_list "States" machine.states;
		Printf.printf "Initial: %s\n" machine.initial;
		print_list "Finals" machine.finals;
	
		(* Affichage des transitions *)
		List.iter (fun (state, transitions) ->
			List.iter (fun t ->
				Printf.printf "(%s, %s) -> (%s, %s, %s)\n"
					state t.read t.to_state t.write t.action
			) transitions
		) machine.transitions;
	
		Printf.printf "*************************************\n";