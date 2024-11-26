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

val print_machine : turing_machine -> unit
