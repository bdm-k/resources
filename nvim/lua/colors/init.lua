local background = '#18181a'
local foreground = '#dcdfe4'
local orange = '#d19a66'
local yellow = '#e5c07b'
local magenta = '#c678dd'
local comment = '#7f848e'

local diagnostic_error = '#ef596f'
local diagnostic_hint = '#61afef'
local diagnostic_warn = orange

local primary = '#e4609b'
local secondary = '#47bac0'

local vibrant_green = '#6af376'
local vibrant_yellow = '#f1ff5e'

local noir9 = '#000000'
local noir8 = background
local noir7 = '#434852'
local noir6 = '#616670'
local noir5 = comment
local noir4 = '#959ba6'
local noir3 = '#abb2bf'
local noir2 = '#c3c8d1'
local noir1 = foreground
local noir0 = '#ffffff'


-- Common
vim.api.nvim_set_hl(0, 'Normal', { bg = "none" })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = noir9, blend = 24 })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = noir9, blend = 24 })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = primary, bold = true })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = noir5 })

-- Treesitter
vim.api.nvim_set_hl(0, '@string', { fg = primary })
vim.api.nvim_set_hl(0, '@boolean', { fg = orange })
vim.api.nvim_set_hl(0, '@number', { fg = orange })
vim.api.nvim_set_hl(0, '@constant.builtin', { fg = orange })
vim.api.nvim_set_hl(0, '@keyword', { fg = magenta })
vim.api.nvim_set_hl(0, '@type', { fg = yellow })
vim.api.nvim_set_hl(0, '@comment', { fg = comment, italic = true })
-- lua
vim.api.nvim_set_hl(0, '@constructor.lua', { fg = foreground })

-- Diagnostic
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', {
  undercurl = true,
  sp = diagnostic_error,
})
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = diagnostic_error })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = diagnostic_hint })


-- Export colors
local M = {
  bg = background,
  fg = foreground,
  orange = orange,
  magenta = magenta,
  comment = comment,

  diagnostic_error = diagnostic_error,
  diagnostic_hint = diagnostic_hint,
  diagnostic_warn = diagnostic_warn,

  primary = primary,
  secondary = secondary,

  vibrant_green = vibrant_green,
  vibrant_yellow = vibrant_yellow,

  noir9 = noir9,
  noir8 = noir8,
  noir7 = noir7,
  noir6 = noir6,
  noir5 = noir5,
  noir4 = noir4,
  noir3 = noir3,
  noir2 = noir2,
  noir1 = noir1,
  noir0 = noir0,
}
return M
