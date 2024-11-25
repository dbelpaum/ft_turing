type transition = {
  read: char;
  to_state: string;
  write: char;
  action: string;
}

type machine = {
  name: string;
  alphabet: char list;
  blank: char;
  states: string list;
  initial: string;
  finals: string list;
  transitions: (string * transition list) list;
}

val simulate : machine -> string -> unit
