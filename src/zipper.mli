type 'a t
(** Type abstrait représentant un zipper avec des éléments de type ['a]. *)

val make : 'a -> 'a t
(** [make blank] crée un zipper initialisé avec une valeur blanche [blank] au centre. *)

val current : 'a t -> 'a
(** [current z] retourne l'élément courant du zipper [z]. *)

val write : 'a -> 'a t -> 'a t
(** [write value z] retourne un nouveau zipper avec [value] écrit à la position courante. *)

val move_left : 'a -> 'a t -> 'a t
(** [move_left blank z] déplace le curseur à gauche. Si la bande est vide à gauche, une case avec [blank] est ajoutée. *)

val move_right : 'a -> 'a t -> 'a t
(** [move_right blank z] déplace le curseur à droite. Si la bande est vide à droite, une case avec [blank] est ajoutée. *)

val to_list : 'a t -> 'a list
(** [to_list z] retourne une représentation sous forme de liste complète du zipper. *)

val to_string : char t -> string
(** [to_string z] retourne une représentation sous forme de chaîne de caractères du zipper. *)

val of_list : 'a list -> 'a -> 'a t
(** [of_list lst blank] initialise un zipper à partir d'une liste [lst] et d'une valeur blanche [blank]. *)