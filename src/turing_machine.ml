open Yojson.Basic.Util

type transition = {
  read: char;
  to_state: string;
  write: char;
  action: string;
}

type machine = {
  name: string;
  alphabet: char list;
  blank: char;
  states: string list;
  initial: string;
  finals: string list;
  transitions: (string * transition list) list;
}

let simulate machine input =
  (* Simulation logic will be implemented here *)
  Printf.printf "Simulating machine: %s\n" machine.name

let parse_machine jsonfile =
  (* Parse the JSON description and return a machine *)
  let json = Yojson.Basic.from_file jsonfile in
  {
    name = json |> member "name" |> to_string;
    alphabet = json |> member "alphabet" |> to_list |> filter_string |> List.map String.get 0;
    blank = json |> member "blank" |> to_string |> String.get 0;
    states = json |> member "states" |> to_list |> filter_string;
    initial = json |> member "initial" |> to_string;
    finals = json |> member "finals" |> to_list |> filter_string;
    transitions =
      json |> member "transitions" |> to_assoc
      |> List.map (fun (state, transitions) ->
           (state, transitions |> to_list |> List.map (fun t ->
             {
               read = t |> member "read" |> to_string |> String.get 0;
               to_state = t |> member "to_state" |> to_string;
               write = t |> member "write" |> to_string |> String.get 0;
               action = t |> member "action" |> to_string;
             }
           ))
         )
  }
