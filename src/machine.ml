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
	
		Printf.printf "********************************************************************************\n";
		Printf.printf "*\n";
		Printf.printf "* %s *\n" machine.name;
		Printf.printf "*\n";
		Printf.printf "********************************************************************************\n";
	
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