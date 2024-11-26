open Yojson.Basic.Util
open Machine

let parse_machine jsonfile =
  (* Parse the JSON description and return a machine *)
  let json = Yojson.Basic.from_file jsonfile in
  {
    name = json |> Yojson.Basic.Util.member "name" |> Yojson.Basic.Util.to_string;
    alphabet = json |> Yojson.Basic.Util.member "alphabet" |> Yojson.Basic.Util.to_list |> List.map Yojson.Basic.Util.to_string;
    blank = json |> Yojson.Basic.Util.member "blank" |> Yojson.Basic.Util.to_string;
    states = json |> Yojson.Basic.Util.member "states" |> Yojson.Basic.Util.to_list |> List.map Yojson.Basic.Util.to_string;
    initial = json |> Yojson.Basic.Util.member "initial" |> Yojson.Basic.Util.to_string;
    finals = json |> Yojson.Basic.Util.member "finals" |> Yojson.Basic.Util.to_list |> List.map Yojson.Basic.Util.to_string;
    transitions =
      json |> Yojson.Basic.Util.member "transitions" |> Yojson.Basic.Util.to_assoc
      |> List.map (fun (state, transitions) ->
           (state, transitions |> Yojson.Basic.Util.to_list |> List.map (fun t ->
             {
               read = t |> Yojson.Basic.Util.member "read" |> Yojson.Basic.Util.to_string;
               to_state = t |> Yojson.Basic.Util.member "to_state" |> Yojson.Basic.Util.to_string;
               write = t |> Yojson.Basic.Util.member "write" |> Yojson.Basic.Util.to_string;
               action = t |> Yojson.Basic.Util.member "action" |> Yojson.Basic.Util.to_string;
             }
           ))
         )
  }