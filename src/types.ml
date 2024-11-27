type direction = Left | Right

type transition = {
  read: char;
  to_state: string;
  write: char;
  action: direction;
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

exception Parsing_error of string
exception Input_error of string
exception Infinite_loop of string
