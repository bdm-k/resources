local M = {}


local palette = require('colors')
local theme = {
  normal = {
    a = { bg = palette.secondary, fg = palette.bg, gui = 'bold' },
    b = { bg = palette.fg, fg = palette.bg, gui = 'bold' },
    c = { bg = palette.noir5, fg = palette.fg },
  },
  insert = {
    a = { bg = palette.vibrant_green, fg = palette.bg, gui = 'bold' },
    b = { bg = palette.fg, fg = palette.bg, gui = 'bold' },
    c = { bg = palette.noir5, fg = palette.fg },
  },
  visual = {
    a = { bg = palette.vibrant_yellow, fg = palette.bg, gui = 'bold' },
    b = { bg = palette.fg, fg = palette.bg, gui = 'bold' },
    c = { bg = palette.noir5, fg = palette.fg },
  },
  replace = {
    a = { bg = palette.secondary, fg = palette.bg, gui = 'bold' },
    b = { bg = palette.fg, fg = palette.bg, gui = 'bold' },
    c = { bg = palette.noir5, fg = palette.fg },
  },
  command = {
    a = { bg = palette.primary, fg = palette.bg, gui = 'bold' },
    b = { bg = palette.fg, fg = palette.bg, gui = 'bold' },
    c = { bg = palette.noir5, fg = palette.fg },
  },
  inactive = {
    a = { bg = palette.secondary, fg = palette.bg, gui = 'bold' },
    b = { bg = palette.fg, fg = palette.bg, gui = 'bold' },
    c = { bg = palette.noir7, fg = palette.noir0 },
  },
}


-- Disable default highlight groups for the statusline
vim.api.nvim_set_hl(0, 'StatusLine', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'Normal' })


-- Create highlight groups for the diagnostic component
vim.api.nvim_set_hl(0, 'LualineDiagnosticError', {
  fg = palette.diagnostic_error,
  bold = true,
})
vim.api.nvim_set_hl(0, 'LualineDiagnosticWarn', {
  fg = palette.diagnostic_warn,
  bold = true,
})
vim.api.nvim_set_hl(0, 'LualineDiagnosticHint', {
  fg = palette.diagnostic_hint,
  bold = true,
})


-- The setup function
M.setup = function()
  require('lualine').setup({
    options = { theme = theme },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        { 'filename', path = 1 },
      },
      lualine_c = {
        {
          'diagnostics',
          diagnostics_color = {
            error = 'LualineDiagnosticError',
            warn = 'LualineDiagnosticWarn',
            hint = 'LualineDiagnosticHint',
          },
        },
      },
      lualine_x = {},
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        { 'filename', path = 1 },
      },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  })
end


return M
