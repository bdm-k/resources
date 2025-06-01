.PHONY: show_targets
show_targets:
	@echo "Available targets: update, clean"

.PHONY: update
update:
	cp flake.nix home.nix ~/.config/home-manager/
	home-manager switch

PHONY: clean
clean:
	nix-collect-garbage -d
