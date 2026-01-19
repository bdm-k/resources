HM_DIR = $(HOME)/.config/home-manager
CONFIG_DIR = $(HOME)/.config
ROOT = $(HOME)/resources

SYMLINKS = $(CONFIG_DIR)/starship.toml $(CONFIG_DIR)/nvim/init.lua \
	   $(CONFIG_DIR)/nvim/lua $(CONFIG_DIR)/opencode/command \
	   $(CONFIG_DIR)/opencode/commands $(CONFIG_DIR)/opencode/opencode.jsonc

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

$(CONFIG_DIR)/nvim/init.lua: | $(ROOT)/nvim/init.lua
	mkdir -p $(CONFIG_DIR)/nvim
	ln -s $(ROOT)/nvim/init.lua $@

$(CONFIG_DIR)/nvim/lua: | $(ROOT)/nvim/lua
	mkdir -p $(CONFIG_DIR)/nvim
	ln -s $(ROOT)/nvim/lua $@

# for backward compatibility
$(CONFIG_DIR)/opencode/command: | $(ROOT)/opencode/commands
	mkdir -p $(CONFIG_DIR)/opencode
	ln -s $(ROOT)/opencode/commands $@

$(CONFIG_DIR)/opencode/commands: | $(ROOT)/opencode/commands
	mkdir -p $(CONFIG_DIR)/opencode
	ln -s $(ROOT)/opencode/commands $@

$(CONFIG_DIR)/opencode/opencode.jsonc: | $(ROOT)/opencode/opencode.jsonc
	mkdir -p $(CONFIG_DIR)/opencode
	ln -s $(ROOT)/opencode/opencode.jsonc $@

.PHONY: clean_symlinks
clean_symlinks:
	rm -rf $(SYMLINKS)

.PHONY: nix-gc
nix-gc:
	nix-collect-garbage -d
