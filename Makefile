NAME	 		= ft_turing
FLAGS 			= -package yojson -linkpkg -I $(SRC_DIR)
OCAMLC 			= ocamlfind ocamlc
OCAMLOPT 		= ocamlfind ocamlopt
SRC_DIR 		= src
ML_FILES 		=	types.ml	\
					machine.ml	\
					parsing.ml	\
					zipper.ml	\
					main.ml

MLI_FILES		=	types.mli 	\
					machine.mli	\
					parsing.mli	\
					zipper.mli	\




ML_SRCS			=	$(addprefix $(SRC_DIR)/, $(ML_FILES))
MLI_SRCS		=	$(addprefix $(SRC_DIR)/, $(MLI_FILES))
CMI_FILES 		= $(MLI_SRCS:%.mli=%.cmi)
CMO_FILES 		= $(ML_SRCS:%.ml=%.cmo)
CMX_FILES 		= $(ML_SRCS:%.ml=%.cmx)

BYTE_EXE 		=	$(NAME).byte
NATIVE_EXE		=	$(NAME)

.PHONY: all build deps clean fclean re

all: $(NATIVE_EXE) # TODO add install rule as dependance before submitting the project

# Byte-code compilation
$(BYTE_EXE): $(CMI_FILES) $(CMO_FILES)
	$(OCAMLC) $(FLAGS) -o $@ $(CMX_FILES)

# Native compilation
$(NATIVE_EXE): $(CMI_FILES) $(CMX_FILES)
	$(OCAMLOPT) $(FLAGS) -o $@ $(CMX_FILES)

# Generic rules for byte-code compilation
%.cmo: %.ml %.cmi
	$(OCAMLC) $(FLAGS) -c $<

# Generic rules for native compilation
%.cmx: %.ml %.cmi
	$(OCAMLOPT) $(FLAGS) -c $<

# Compile interface files
%.cmi: %.mli
	$(OCAMLC) $(FLAGS) -c $<

# For modules without .mli files
%.cmi: %.ml
	$(OCAMLC) $(FLAGS) -c $<

deps install:
	opam install --deps-only .
#	eval $(opam env)

clean:
	rm -f $(NAME) src/*.cm* src/*.o

fclean: clean
	rm -f $(NAME)

re: fclean all
