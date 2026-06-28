HM_DIR = $(HOME)/.config/home-manager
CONFIG_DIR = $(HOME)/.config
ROOT = $(HOME)/resources
VSCODE_DIR = $(HOME)/Library/Application\ Support/Code/User

SYMLINKS = $(CONFIG_DIR)/starship.toml $(VSCODE_DIR)/keybindings.json \
	   $(VSCODE_DIR)/settings.json $(CONFIG_DIR)/wezterm/wezterm.lua \
	   $(CONFIG_DIR)/nvim/init.lua $(CONFIG_DIR)/nvim/lua

.PHONY: show_targets
show_targets:
	@echo "Available targets: update, symlinks, clean_symlinks, nix-gc"

.PHONY: update
update:
	cp flake.nix home.nix ~/.config/home-manager/
	home-manager switch --impure

.PHONY: symlinks
symlinks: $(SYMLINKS)

$(CONFIG_DIR):
	mkdir -p $@

$(CONFIG_DIR)/starship.toml: | $(CONFIG_DIR) $(ROOT)/starship.toml
	ln -s $(ROOT)/starship.toml $@

$(VSCODE_DIR)/keybindings.json: | $(ROOT)/vscode/keybindings.json
	mkdir -p $(VSCODE_DIR)
	ln -s $(ROOT)/vscode/keybindings.json $@

$(VSCODE_DIR)/settings.json: | $(ROOT)/vscode/settings.json
	mkdir -p $(VSCODE_DIR)
	ln -s $(ROOT)/vscode/settings.json $@

$(CONFIG_DIR)/wezterm/wezterm.lua: | $(ROOT)/wezterm/wezterm.lua
	mkdir -p $(CONFIG_DIR)/wezterm
	ln -s $(ROOT)/wezterm/wezterm.lua $@

$(CONFIG_DIR)/nvim/init.lua: | $(ROOT)/nvim/init.lua
	mkdir -p $(CONFIG_DIR)/nvim
	ln -s $(ROOT)/nvim/init.lua $@

$(CONFIG_DIR)/nvim/lua: | $(ROOT)/nvim/lua
	mkdir -p $(CONFIG_DIR)/nvim
	ln -s $(ROOT)/nvim/lua $@

.PHONY: clean_symlinks
clean_symlinks:
	rm -rf $(SYMLINKS)

.PHONY: nix-gc
nix-gc:
	nix-collect-garbage -d
