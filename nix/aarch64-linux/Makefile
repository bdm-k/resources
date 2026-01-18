HM_DIR = $(HOME)/.config/home-manager
CONFIG_DIR = $(HOME)/.config
ROOT = $(HOME)/resources

SYMLINKS = $(CONFIG_DIR)/starship.toml $(CONFIG)/nvim/init.lua \
	   $(CONFIG_DIR)/nvim/lua

.PHONY: show_targets
show_targets:
	@echo "Available targets: update, symlinks, clean_symlinks, nix-gc"

.PHONY: update
update:
	cp flake.nix home.nix ~/.config/home-manager/
	home-manager switch --impure

.PHONY: symlinks
symlinks: $(SYMLINKS)

$(CONFIG_DIR)/starship.toml: $(ROOT)/starship.toml
	ln -s $< $@

$(CONFIG_DIR)/nvim/init.lua: $(ROOT)/nvim/init.lua
	mkdir -p $(CONFIG_DIR)/nvim
	ln -s $< $@

$(CONFIG_DIR)/nvim/lua: $(ROOT)/nvim/lua
	mkdir -p $(CONFIG_DIR)/nvim
	ln -s $< $@

.PHONY: clean_symlinks
clean_symlinks:
	rm $(SYMLINKS)

.PHONY: nix-gc
nix-gc:
	nix-collect-garbage -d
