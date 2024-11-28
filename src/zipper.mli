open Types

val make : char -> zipper

val current : zipper -> char

val write : char -> zipper -> zipper

val move_left : char -> zipper -> zipper

val move_right : char -> zipper -> zipper

val format_tape : zipper -> char -> string

val get_tape_str : zipper -> string

val of_list : char list -> char -> zipper

val left_is_empty : zipper -> bool

val right_is_empty : zipper -> bool