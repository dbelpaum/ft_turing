open Machine
open Parsing

let print_usage () =
  print_endline "Usage: ft_turing [-h] jsonfile input";
  print_endline "";
  print_endline "positional arguments:";
  print_endline "  jsonfile    json description of the machine";
  print_endline "";
  print_endline "  input       input of the machine";
  print_endline "";
  print_endline "optional arguments:";
  print_endline "  -h, --help  show this help message and exit"

let () =
  match Array.to_list Sys.argv with
  | [_; "-h"] | [_; "--help"] -> print_usage ()
  | [_; jsonfile; input] ->
      (* Appeler la fonction parse_machine et print_machine *)
      let machine = Parsing.parse_machine jsonfile in
      Machine.print_machine machine;
      (* Pour l'instant, juste afficher l'entrée et JSON sans traitement supplémentaire *)
      print_endline ("Running with input: " ^ input);
  | _ -> print_usage ()
