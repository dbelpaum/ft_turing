let padding_size = 100

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

module StateTapeSet = Set.Make(struct
  type t = string * zipper
  let compare (s1, t1) (s2, t2) =
    let cmp_state = String.compare s1 s2 in
    if cmp_state <> 0 then cmp_state
    else
      let cmp_left = String.compare t1.left t2.left in
      if cmp_left <> 0 then cmp_left
      else
        let cmp_cursor = Char.compare t1.cursor t2.cursor in
        if cmp_cursor <> 0 then cmp_cursor
        else String.compare t1.right t2.right
end)

exception Parsing_error of string
exception Input_error of string
exception Infinite_loop of string
exception Read_Not_Found of string
