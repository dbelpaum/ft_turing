(** Module implémentant une structure zipper fonctionnelle pour la bande de Turing. *)

type 'a t = {
  left: 'a list;  (** Éléments à gauche de la position courante (ordre inverse). *)
  current: 'a;    (** Élément sous le curseur. *)
  right: 'a list; (** Éléments à droite de la position courante. *)
}

(** [make blank] crée un zipper initialisé avec une valeur blanche [blank] au centre. *)
let make blank = { left = []; current = blank; right = [] }

(** [current z] retourne l'élément courant du zipper [z]. *)
let current z = z.current

(** [write value z] retourne un nouveau zipper avec [value] écrit à la position courante. *)
let write value z = { z with current = value }

(** [move_left blank z] déplace le curseur à gauche. Si la bande est vide à gauche, une case avec [blank] est ajoutée. *)
let move_left blank z =
  match z.left with
  | [] -> { left = []; current = blank; right = z.current :: z.right }
  | h :: t -> { left = t; current = h; right = z.current :: z.right }

(** [move_right blank z] déplace le curseur à droite. Si la bande est vide à droite, une case avec [blank] est ajoutée. *)
let move_right blank z =
  match z.right with
  | [] -> { left = z.current :: z.left; current = blank; right = [] }
  | h :: t -> { left = z.current :: z.left; current = h; right = t }

(** [to_list z] retourne une représentation sous forme de liste complète du zipper. *)
let to_list z =
  List.rev z.left @ (z.current :: z.right)


let to_string z =
  let left = String.concat "" (List.map (String.make 1) (List.rev z.left)) in
  let current = String.make 1 z.current in
  let right = String.concat "" (List.map (String.make 1) z.right) in
  Printf.sprintf "[%s<%s>%s]" left current right
  

(** [of_list lst blank] initialise un zipper à partir d'une liste [lst] et d'une valeur blanche [blank]. *)
let of_list lst blank =
  match lst with
  | [] -> make blank
  | h :: t -> { left = []; current = h; right = t }