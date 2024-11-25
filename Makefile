PROJECT = ft_turing
OCAMLFIND = ocamlfind
OCAMLFLAGS = -linkpkg -package yojson
SRC_DIR = src
SOURCES = $(wildcard $(SRC_DIR)/*.ml)

.PHONY: all build deps clean fclean re

all: deps build

deps:
	opam install --deps-only .

build:
	$(OCAMLFIND) ocamlopt $(OCAMLFLAGS) -o $(PROJECT) $(SOURCES)

clean:
	rm -f $(PROJECT) *.cm* *.o

fclean: clean
	rm -f $(PROJECT)

re: clean all

# opam switch create . ocaml-base-compiler.4.14.0
# opam install --deps-only .
