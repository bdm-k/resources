.PHONY: update
update:
	cp flake.nix home.nix ~/.config/home-manager/
	home-manager switch

PHONY: clean
clean:
	nix-collect-garbage
