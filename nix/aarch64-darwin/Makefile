.PHONY: show_targets
show_targets:
	@echo "Available targets: update, symlinks, clean_symlinks, nix-gc"

.PHONY: update
update:
	cp flake.nix home.nix ~/.config/home-manager/
	home-manager switch --impure

.PHONY: symlinks
symlinks:
	sh manage_symlinks.sh symlinks

.PHONY: clean_symlinks
clean_symlinks:
	sh manage_symlinks.sh clean_symlinks

.PHONY: nix-gc
nix-gc:
	nix-collect-garbage -d
