# ft_turing

## Description
This project is a Turing machine simulator written in OCaml.

It reads a description of a Turing machine from a json file and a tape from standard input, then executes the turing machine.


## Usage
```
make install
eval $(opam env)
make
./ft_turing [turing_machine_file.json] [tape]
```

## Machines
This project comes with pre-defined machines :
- `unary_add.json` : Adds two unary numbers
- `palindrome.json` : Check if a word is a palindrome, from an alphabet of 2 symbols 'a' & 'b'
- `02n.json` : Check if a word is of the form 0^2n (ex: 0000 true; 000 false)
- `0n1n.json` : Check if a word is of the form 0^n1^n (ex: 0011 true; 00011 false)