type transition = {
  read: string;
  to_state: string;
  write: string;
  action: string;
}

type turing_machine = {
  name: string;
  alphabet: char list;
  blank: char;
  states: string list;
  initial: string;
  finals: string list;
  transitions: (string * transition list) list;
}

val print_machine : turing_machine -> unit
