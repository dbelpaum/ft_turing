val padding_size : int

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

type zipper = {
  left : string;   (* Partie gauche de la bande *)
  right : string;  (* Partie droite de la bande *)
  cursor : char;   (* Position du curseur sur la bande *)
}

module StateTapeSet : sig
  type t
  val empty : t
  val add : (string * zipper) -> t -> t
  val mem : (string * zipper) -> t -> bool
  val remove : (string * zipper) -> t -> t
  val iter : (string * zipper -> unit) -> t -> unit
end

exception Parsing_error of string
exception Input_error of string
exception Infinite_loop of string
exception Read_Not_Found of string

