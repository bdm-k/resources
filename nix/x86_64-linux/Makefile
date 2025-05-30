OUT_DIR = $(HOME)/.config
SRC_DIR = $(HOME)/resources

TARGETS = $(OUT_DIR)/starship.toml $(OUT_DIR)/Code/User/keybindings.json \
	  $(OUT_DIR)/Code/User/settings.json $(OUT_DIR)/wezterm/wezterm.lua \
	  $(OUT_DIR)/nvim/init.lua $(OUT_DIR)/nvim/lua

.PHONY: all
all: $(TARGETS)

$(OUT_DIR)/starship.toml: $(SRC_DIR)/starship.toml
	ln -s $< $@

$(OUT_DIR)/Code/User/keybindings.json: $(SRC_DIR)/vscode/keybindings.json
	mkdir -p $(OUT_DIR)/Code/User
	ln -s $< $@

$(OUT_DIR)/Code/User/settings.json: $(SRC_DIR)/vscode/settings.json
	mkdir -p $(OUT_DIR)/Code/User
	ln -s $< $@

$(OUT_DIR)/wezterm/wezterm.lua: $(SRC_DIR)/wezterm/wezterm.lua
	mkdir -p $(OUT_DIR)/wezterm
	ln -s $< $@

$(OUT_DIR)/nvim/init.lua: $(SRC_DIR)/nvim/init.lua
	mkdir -p $(OUT_DIR)/nvim
	ln -s $< $@

$(OUT_DIR)/nvim/lua: $(SRC_DIR)/nvim/lua
	mkdir -p $(OUT_DIR)/nvim
	ln -s $< $@

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

.PHONY: clean
clean:
	rm -rf $(TARGETS)
