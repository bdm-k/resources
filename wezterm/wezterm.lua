local wezterm = require("wezterm")
local act = wezterm.action
local nerd = wezterm.nerdfonts
local config = wezterm.config_builder()

-- Setup domains
config.unix_domains = {
  {
    name = "kokus-lab",
    proxy_command = { "ssh", "-T", "kokus-lab", "wezterm", "cli", "proxy" },
  }
}

config.font = wezterm.font("Source Code Pro")
config.window_frame = {
  font = wezterm.font({
    family = "Avenir Next",
    weight = "DemiBold",
  }),
}

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
-- Append the domain name if it is not the local domain
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  local pane = tab.active_pane
  if pane.is_zoomed then
    title = "🔎 " .. title
  end
  if pane.domain_name ~= "local" then
    title = title .. " 🌐 " .. pane.domain_name
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
    key = "x", mods = "CMD",
    action = act.CloseCurrentPane({ confirm = false }),
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

  -- Assignments for Linux. Adapt some key assignments to macOS style
  {
    key = "v", mods = "SUPER",
    action = act.PasteFrom 'Clipboard',
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
  copy_mode = copy_mode,
}

return config
