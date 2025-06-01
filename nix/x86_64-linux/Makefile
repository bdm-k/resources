HM_DIR = $(HOME)/.config/home-manager
CONFIG_DIR = $(HOME)/.config
ROOT = $(HOME)/resources

SYMLINKS = $(CONFIG_DIR)/starship.toml $(CONFIG_DIR)/Code/User/keybindings.json \
	  $(CONFIG_DIR)/Code/User/settings.json $(CONFIG_DIR)/wezterm/wezterm.lua \
	  $(CONFIG_DIR)/nvim/init.lua $(CONFIG_DIR)/nvim/lua

.PHONY: show_targets
show_targets:
	@echo "Available targets: symlinks, clean_symlinks, nix-gc"

$(HM_DIR)/flake.nix: flake.nix
	cp @< $@

$(HM_DIR)/home.nix: home.nix
	cp @< $@

.PHONY: symlinks
symlinks: $(SYMLINKS) 

$(CONFIG_DIR)/starship.toml: $(ROOT)/starship.toml
	ln -s $< $@

$(CONFIG_DIR)/Code/User/keybindings.json: $(ROOT)/vscode/keybindings.json
	mkdir -p $(CONFIG_DIR)/Code/User
	ln -s $< $@

$(CONFIG_DIR)/Code/User/settings.json: $(ROOT)/vscode/settings.json
	mkdir -p $(CONFIG_DIR)/Code/User
	ln -s $< $@

$(CONFIG_DIR)/wezterm/wezterm.lua: $(ROOT)/wezterm/wezterm.lua
	mkdir -p $(CONFIG_DIR)/wezterm
	ln -s $< $@

$(CONFIG_DIR)/nvim/init.lua: $(ROOT)/nvim/init.lua
	mkdir -p $(CONFIG_DIR)/nvim
	ln -s $< $@

$(CONFIG_DIR)/nvim/lua: $(ROOT)/nvim/lua
	mkdir -p $(CONFIG_DIR)/nvim
	ln -s $< $@

$(CONFIG_DIR):
	mkdir -p $(CONFIG_DIR)

.PHONY: clean_symlinks
clean_symlinks:
	rm $(SYMLINKS)

.PHONY: nix-gc
	nix-garbage-collect -d
