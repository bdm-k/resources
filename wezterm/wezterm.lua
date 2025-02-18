local wezterm = require("wezterm")
local act = wezterm.action
local nerd = wezterm.nerdfonts
local config = wezterm.config_builder()

config.debug_key_events = true

local kernel_name = (function()
  local handle = io.popen("uname -s")
  local result = handle:read("*a"):gsub("\n$", "")
  handle:close()
  return result
end)()

-- Setup domains
config.unix_domains = {
  {
    name = "kokus-lab",
    proxy_command = { "ssh", "-T", "kokus-lab", "wezterm", "cli", "proxy" },
  }
}

-- Setup the fonts
config.font = wezterm.font("Source Code Pro")
if kernel_name == "Darwin" then
  config.window_frame = {
    font = wezterm.font({
      family = "Avenir Next",
      weight = "DemiBold",
    })
  }
else
  config.window_frame = {
    font = wezterm.font({
      family = "Noto Sans CJK JP",
      weight = "Medium",
    }),
    font_size = 11.0,
  }
end

config.color_scheme = "One Half Black (Gogh)"
local color_scheme_bg = wezterm.color.parse("#000000")
local color_scheme_fg = wezterm.color.parse("#dcdfe4")
local color_scheme_black = wezterm.color.parse("#282C34")
local tab_bar_bg = wezterm.color.parse("#333333")
local highlight_bg = wezterm.color.parse("#334f70")

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = color_scheme_bg,
      fg_color = color_scheme_fg,
    },
    inactive_tab_edge = tab_bar_bg, -- hide the edge
  },
  selection_bg = highlight_bg,
  selection_fg = '#ffffff',
  copy_mode_active_highlight_bg = { Color = color_scheme_black },
  copy_mode_active_highlight_fg = { Color = color_scheme_fg },
  copy_mode_inactive_highlight_bg = { Color = color_scheme_black },
  copy_mode_inactive_highlight_fg = { Color = color_scheme_fg },
}

config.inactive_pane_hsb = {
  saturation = 0.64,
  brightness = 0.24,
}

config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"

-- This function returns the suggested title for a tab. It prefers the title
-- that was set via `tab:set_title()` or `wezterm cli set-tab-title`, but falls
-- back to the title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end

-- Prefix the tab title with 🔎 if the active pane in the tab is zoomed
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  local pane = tab.active_pane
  if pane.is_zoomed then
    title = "🔎 " .. title
  end
  return title
end)

-- Display text according to the current key table
wezterm.on("update-status", function(window, pane)
  local map = {
    resize_pane = "   <RESIZE>   ",
    search_mode = "   <SEARCH>   ",
    copy_mode = "   <COPY>   ",
  }
  local key_table_name = window:active_key_table()
  local text = map[key_table_name] or ""
  window:set_right_status(wezterm.format({
    { Foreground = { Color = color_scheme_fg } },
    { Text = text },
  }))
end)

config.keys = {
  -- Disable some default assignments
  {
    key = "k", mods = "CMD",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "h", mods = "CMD",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "r", mods = "CMD",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "n", mods = "CMD",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "-", mods = "CTRL",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "=", mods = "CTRL",
    action = act.DisableDefaultAssignment,
  },

  -- Assignments related to Pane
  {
    key = "e", mods = "CMD|OPT",
    action = act.SplitPane({ direction = "Up" }),
  },
  {
    key = "i", mods = "CMD|OPT",
    action = act.SplitPane({ direction = "Right" }),
  },
  {
    key = "n", mods = "CMD|OPT",
    action = act.SplitPane({ direction = "Down" }),
  },
  {
    key = "h", mods = "CMD|OPT",
    action = act.SplitPane({ direction = "Left" }),
  },
  {
    key = "e", mods = "CMD",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "i", mods = "CMD",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "n", mods = "CMD",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "h", mods = "CMD",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "z", mods = "CMD",
    action = act.TogglePaneZoomState,
  },
  {
    key = "r", mods = "CMD",
    action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
  },

  -- Assignments related to Tab
  {
    key = "[", mods = "CMD",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "]", mods = "CMD",
    action = act.ActivateTabRelative(1),
  },

  -- Assignments for Linux
  -- Adapt some key assignments to macOS style
  {
    key = "v", mods = "SUPER",
    action = act.PasteFrom 'Clipboard',
  },
  -- When an arrow key is pressed with CTRL, ignore the CTRL.
  -- These assignments are for compatibility with xremap.
  {
    key = "LeftArrow", mods = "CTRL",
    action = act.SendKey { key = "LeftArrow" },
  },
  {
    key = "DownArrow", mods = "CTRL",
    action = act.SendKey { key = "DownArrow" },
  },
  {
    key = "UpArrow", mods = "CTRL",
    action = act.SendKey { key = "UpArrow" },
  },
  {
    key = "RightArrow", mods = "CTRL",
    action = act.SendKey { key = "RightArrow" },
  },
  -- When the signs are input with all modifiers, ignore the modifiers.
  -- These assignments are for compatibility with xremap.
  {
    key = "`", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "`" },
  },
  {
    key = "~", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "~" },
  },
  {
    key = "1", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "1" },
  },
  {
    key = "!", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "!" },
  },
  {
    key = "2", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "2" },
  },
  {
    key = "@", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "@" },
  },
  {
    key = "3", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "3" },
  },
  {
    key = "#", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "#" },
  },
  {
    key = "4", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "4" },
  },
  {
    key = "$", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "$" },
  },
  {
    key = "5", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "5" },
  },
  {
    key = "%", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "%" },
  },
  {
    key = "6", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "6" },
  },
  {
    key = "^", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "^" },
  },
  {
    key = "7", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "7" },
  },
  {
    key = "&", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "&" },
  },
  {
    key = "8", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "8" },
  },
  {
    key = "*", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "*" },
  },
  {
    key = "9", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "9" },
  },
  {
    key = "(", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = "(" },
  },
  {
    key = "0", mods = "SUPER|ALT|CTRL",
    action = act.SendKey { key = "0" },
  },
  {
    key = ")", mods = "SUPER|ALT|CTRL|SHIFT",
    action = act.SendKey { key = ")" },
  },

  -- Other assignments
  {
    key = "k", mods = "OPT",
    action = act.Multiple {
      act.ClearScrollback("ScrollbackAndViewport"),
      act.SendKey { key = "L", mods = "CTRL" },
    }
  },
  {
    key = "h", mods = "OPT",
    action = act.HideApplication,
  },
  {
    key = "phys:p", mods = "CMD|SHIFT",
    action = act.ActivateCommandPalette,
  },
  {
    key = "F1",
    action = act.QuickSelect,
  },
  {
    key = "F3",
    action = act.ActivateCopyMode,
  },
}

-- Add key assignments for the copy mode key table
local copy_mode = wezterm.gui.default_key_tables().copy_mode
table.insert(
  copy_mode,
  { key = "Backspace", mods = "CMD", action = act.CopyMode "ClearPattern" }
)

config.key_tables = {
  resize_pane = {
    { key = "e", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 10 }) },
    { key = "i", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 10 }) },
    { key = "n", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 10 }) },
    { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 10 }) },
    { key = "Escape", action = "PopKeyTable" },
  },
  search_mode = {
    { key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
    { key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    { key = "Enter", mods = "NONE", action = act.CopyMode("AcceptPattern") }, -- Enter Copy Mode
    { key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
    { key = "Backspace", mods = "CMD", action = act.CopyMode "ClearPattern" },
    { key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
  },

  -- NOTE: When you are in copy mode and want to modify the pattern, press CMD+f
  -- to enter search mode.
  copy_mode = copy_mode,
}

return config
