# ft_turing 🔢

![image](https://i.imgur.com/QLa3TGh.gif)

## 📝 Description
This project is a Turing machine simulator written in [OCaml](https://en.wikipedia.org/wiki/OCaml).

It reads a description of a [Turing machine](https://en.wikipedia.org/wiki/Turing_machine) from a json file and a tape from standard input, then executes the turing machine.


## 📦 Installation
```
make install
eval $(opam env)
make
./ft_turing [turing_machine_file.json] [tape]
```

## 📝 JSON
Here is a concise explanation in English for your README:

---

### How to Program a Turing Machine in JSON

To define a Turing machine using JSON, you must provide a structured description of its components. Here's a breakdown of the required fields:

- **`name`**: A descriptive name for the machine.
- **`alphabet`**: The set of symbols the machine can recognize, including the blank symbol.
- **`blank`**: The symbol used for empty spaces on the tape.
- **`states`**: A list of all possible states of the machine.
- **`initial`**: The starting state of the machine.
- **`finals`**: A list of halting states where the machine stops.
- **`transitions`**: The rules defining the machine's behavior. Each state maps to a list of transitions, where:
  - **`read`**: Specifies the symbol to read.
  - **`to_state`**: The state to transition to.
  - **`write`**: The symbol to write on the tape.
  - **`action`**: The direction to move the tape head (`"LEFT"` or `"RIGHT"`).

Here's an example of a JSON representation of a Turing machine:
  ```json
{
	"name" : "unary_sub",
	"alphabet": [ "1", ".", "-", "=" ],
	"blank" : ".",
	"states" : [ "scanright", "eraseone", "subone", "skip", "HALT" ],
	"initial" : "scanright",
	"finals" : [ "HALT" ],
	"transitions" : {
		"scanright": [
			{ "read" : ".", "to_state": "scanright", "write": ".", "action": "RIGHT"},
			{ "read" : "1", "to_state": "scanright", "write": "1", "action": "RIGHT"},
			{ "read" : "-", "to_state": "scanright", "write": "-", "action": "RIGHT"},
			{ "read" : "=", "to_state": "eraseone" , "write": ".", "action": "LEFT" }
		],
		"eraseone": [
			{ "read" : "1", "to_state": "subone", "write": "=", "action": "LEFT"},
			{ "read" : "-", "to_state": "HALT" , "write": ".", "action": "LEFT"}
		],
		"subone": [
			{ "read" : "1", "to_state": "subone", "write": "1", "action": "LEFT"},
			{ "read" : "-", "to_state": "skip" , "write": "-", "action": "LEFT"}
		],
		"skip": [
			{ "read" : ".", "to_state": "skip" , "write": ".", "action": "LEFT"},
			{ "read" : "1", "to_state": "scanright", "write": ".", "action": "RIGHT"}
		]
	}
}
  ```

## 🤖 Machines
This project comes with pre-defined machines :
- `unary_add.json` : Adds two unary numbers
- `palindrome.json` : Check if a word is a palindrome, from an alphabet of 2 symbols 'a' & 'b'
- `02n.json` : Check if a word is of the form 0^2n (ex: 0000 true; 000 false)
- `0n1n.json` : Check if a word is of the form 0^n1^n (ex: 0011 true; 00011 false)

# 🧑 Authors ‍

- [@dbelpaum](https://github.com/dbelpaum)
- [@tsannie](https://github.com/tsannie)
