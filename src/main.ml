open Machine
open Parsing
open Zipper
open Execution
open Types

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

let run_machine blank tape state machine =
  ignore (execute_machine blank tape state machine)

  let () =
  match Array.to_list Sys.argv with
  | [_; "-h"] | [_; "--help"] -> print_usage ()
  | [_; jsonfile; input] ->
      (* Charger la machine *)
      let machine =
        try
        Parsing.parse_machine jsonfile
        with
        | Parsing_error msg -> print_endline msg; exit 1
      in

      let input =
        try
        Parsing.parse_input input machine.alphabet machine.blank
        with
        | Input_error msg -> print_endline msg; exit 1
      in

      (* Afficher la machine *)
      Machine.print_machine machine;

      (* Convertir la chaîne input en une liste de caractères *)
      let input_list = List.init (String.length input) (String.get input) in

      (* Définir le caractère "blanc" pour le Zipper *)
      let blank = machine.blank in

      (* Initialiser le Zipper avec l'entrée *)
      let tape = Zipper.of_list input_list blank in

      run_machine blank tape machine.initial machine

  | _ -> print_usage ()

