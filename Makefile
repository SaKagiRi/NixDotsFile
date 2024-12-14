NAME = home

all: $(NAME)

$(NAME):
	@home-manager switch --flake .

nix:
	@sudo nixos-rebuild switch --flake .

.PHONY: all
