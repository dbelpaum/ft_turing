type zipper
(** Type représentant un zipper contenant des éléments de type [string]. *)

val make : char -> zipper
(** [make blank] crée un zipper initialisé avec une valeur blanche [blank] au centre. *)

val current : zipper -> char
(** [current z] retourne l'élément courant du zipper [z] sous forme de caractère. *)

val write : char -> zipper -> zipper
(** [write value z] retourne un nouveau zipper avec [value] écrit à la position courante. *)

val move_left : char -> zipper -> zipper
(** [move_left blank z] déplace le curseur à gauche. Si la bande est vide à gauche, une case avec [blank] est ajoutée. *)

val move_right : char -> zipper -> zipper
(** [move_right blank z] déplace le curseur à droite. Si la bande est vide à droite, une case avec [blank] est ajoutée. *)

val to_list : zipper -> char list
(** [to_list z] retourne une représentation sous forme de liste complète du zipper. *)

val to_string : zipper -> string
(** [to_string z] retourne une représentation sous forme de chaîne de caractères du zipper. *)

val format_tape : zipper -> char -> string
(** [format_tape z blank] retourne une représentation sous forme de chaîne de caractères du zipper avec des cases vides représentées par [blank]. *)

val of_list : char list -> char -> zipper
(** [of_list lst blank] initialise un zipper à partir d'une liste [lst] et d'une valeur blanche [blank]. *)
