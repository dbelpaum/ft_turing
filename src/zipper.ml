open Utils
open Types

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
  let left_length = String.length z.left in
  let right_length = String.length z.right in
  let total_length = 9 in

  (* S'assurer que left est toujours de 9 caractères, avec des blanks si nécessaire *)
  let left_trimmed = 
    if left_length >= total_length then
      String.sub (reverse_string z.left) (left_length - total_length) total_length
    else
      String.make (total_length - left_length) blank ^ (reverse_string z.left)
  in

  (* S'assurer que right est toujours de 9 caractères, avec des blanks si nécessaire *)
  let right_trimmed =
    if right_length >= total_length then
      String.sub z.right 0 total_length
    else
      z.right ^ String.make (total_length - right_length) blank
  in

  Printf.sprintf "[%s<%s>%s]" left_trimmed (String.make 1 z.cursor) right_trimmed

    
let get_tape_str z = Printf.sprintf "%s%c%s" z.left z.cursor z.right

let of_list lst blank =
  match lst with
  | [] -> make blank
  | h :: t -> { left = ""; cursor = h; right = String.concat "" (List.map (String.make 1) t) }

let left_is_empty z = String.length z.left = 0
let right_is_empty z = String.length z.right = 0