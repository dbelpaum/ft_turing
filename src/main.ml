open Machine
open Parsing
open Zipper
open Execution

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
      (* Charger la machine *)
      let machine = Parsing.parse_machine jsonfile in

      (* Afficher la machine *)
      Machine.print_machine machine;

      (* Convertir la chaîne input en une liste de caractères *)
      let input_list = List.init (String.length input) (String.get input) in

      (* Définir le caractère "blanc" pour le Zipper *)
      let blank = machine.blank in

      (* Initialiser le Zipper avec l'entrée *)
      let tape = Zipper.of_list input_list blank in

      let final_tape = execute_machine blank tape machine.initial machine in
      Printf.printf "%s\n" (Zipper.format_tape final_tape blank);

  | _ -> print_usage ()

