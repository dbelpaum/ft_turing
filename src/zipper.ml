(** Module implémentant une structure zipper fonctionnelle pour la bande de Turing. *)

type zipper = {
  left : string;   (* Partie gauche de la bande *)
  right : string;  (* Partie droite de la bande *)
  cursor : char;   (* Position du curseur sur la bande *)
}

(** [make blank] crée un zipper initialisé avec une valeur blanche [blank] au centre. *)
let make blank = { left = ""; cursor = blank; right = "" }

(** [current z] retourne l'élément courant du zipper [z]. *)
let current z = z.cursor

(** [write value z] retourne un nouveau zipper avec [value] écrit à la position courante. *)
let write value z = { z with cursor = value }

(** [move_left blank z] déplace le curseur à gauche. Si la bande est vide à gauche, une case avec [blank] est ajoutée. *)
let move_left blank z =
  if String.length z.left = 0 then
    { left = ""; cursor = blank; right = (String.make 1 z.cursor) ^ z.right }
  else
    let left_char = String.sub z.left (String.length z.left - 1) 1 in
    let new_left = String.sub z.left 0 (String.length z.left - 1) in
    { left = new_left; cursor = left_char.[0]; right = (String.make 1 z.cursor) ^ z.right }

(** [move_right blank z] déplace le curseur à droite. Si la bande est vide à droite, une case avec [blank] est ajoutée. *)
let move_right blank z =
  if String.length z.right = 0 then
    { left = (String.make 1 z.cursor) ^ z.left; cursor = blank; right = "" }
  else
    let right_char = String.sub z.right 0 1 in
    let new_right = String.sub z.right 1 (String.length z.right - 1) in
    { left = (String.make 1 z.cursor) ^ z.left; cursor = right_char.[0]; right = new_right }

(** [to_list z] retourne une représentation sous forme de liste complète du zipper. *)
let to_list z =
  (String.to_seq z.left |> List.of_seq)
  @ [z.cursor]
  @ (String.to_seq z.right |> List.of_seq)

(** [to_string z] retourne une représentation sous forme de chaîne de caractères du zipper. *)
let to_string z =
  Printf.sprintf "[%s<%s>%s]" z.left (String.make 1 z.cursor) z.right

(** [format_tape z blank] retourne une représentation sous forme de chaîne de caractères du zipper avec des cases vides représentées par [blank]. *)
let format_tape z blank =
  let left_rev = String.concat "" (List.map (String.make 1) (List.rev (List.of_seq (String.to_seq z.left)))) in
  let total_length = 20 in  (* Longueur totale de l'affichage *)
  let left_length = String.length z.left in
  let cursor_length = 1 in  (* La taille du curseur est 1 caractère *)
  let right_trimmed_length = total_length - left_length - cursor_length in

  (* Limiter la longueur de la partie droite à la taille calculée *)
  let right_trimmed = if String.length z.right > right_trimmed_length then
      String.sub z.right 0 right_trimmed_length
    else
      z.right
  in

  (* Calcul du padding à droite pour remplir la longueur restante *)
  let right_blanks = if String.length right_trimmed < right_trimmed_length then
      String.make (right_trimmed_length - String.length right_trimmed) blank
    else
      ""
  in
  Printf.sprintf "[%s<%s>%s%s]" left_rev (String.make 1 z.cursor) right_trimmed right_blanks

(** [of_list lst blank] initialise un zipper à partir d'une liste [lst] et d'une valeur blanche [blank]. *)
let of_list lst blank =
  match lst with
  | [] -> make blank
  | h :: t -> { left = ""; cursor = h; right = String.concat "" (List.map (String.make 1) t) }
