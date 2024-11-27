open Utils

type zipper = {
  left : string;   (* Partie gauche de la bande *)
  right : string;  (* Partie droite de la bande *)
  cursor : char;   (* Position du curseur sur la bande *)
}

let make blank = { left = ""; cursor = blank; right = "" }

let current z = z.cursor

let write value z = { z with cursor = value }

let move_left blank z =
  if String.length z.left = 0 then
    { left = ""; cursor = blank; right = (String.make 1 z.cursor) ^ z.right }
  else
    let left_char = String.sub z.left 0 1 in
    let new_left = String.sub z.left 1 (String.length z.left - 1) in
    { left = new_left; cursor = left_char.[0]; right = (String.make 1 z.cursor) ^ z.right }

let move_right blank z =
  if String.length z.right = 0 then
    { left = (String.make 1 z.cursor) ^ z.left; cursor = blank; right = "" }
  else
    let right_char = String.sub z.right 0 1 in
    let new_right = String.sub z.right 1 (String.length z.right - 1) in
    { left = (String.make 1 z.cursor) ^ z.left; cursor = right_char.[0]; right = new_right }

let format_tape z blank =
  let total_length = 19 in
  let left_length = String.length z.left in
  let right_trimmed_length = total_length - left_length in

  let right_trimmed = if String.length z.right > right_trimmed_length then
      String.sub z.right 0 right_trimmed_length
    else
      z.right
  in

  let right_blanks = if String.length right_trimmed < right_trimmed_length then
      String.make (right_trimmed_length - String.length right_trimmed) blank
    else
      ""
  in
  Printf.sprintf "[%s<%s>%s%s]" (reverse_string z.left) (String.make 1 z.cursor) right_trimmed right_blanks

let of_list lst blank =
  match lst with
  | [] -> make blank
  | h :: t -> { left = ""; cursor = h; right = String.concat "" (List.map (String.make 1) t) }
