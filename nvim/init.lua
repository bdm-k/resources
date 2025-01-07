--[[
Must-know commands:

* '%': Moves the cursor to the matching character.

* 'zt', 'zz', 'zb': These commands make the current line at the top, center, or
  bottom of the window, respectively.
--]]

vim.opt.number = true
vim.opt.relativenumber = true

-- If the search pattern contains uppercase characters, the search will be
-- case-sensitive.
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.cursorline = true

vim.opt.clipboard = 'unnamedplus'

vim.opt.listchars = { tab = ' ', trail = '$' }
vim.opt.list = true

vim.g.mapleader = ' '

vim.diagnostic.config({
  signs = false, -- Disable signs because they cause horizontal layout shift
  virtual_text = false,
  -- Add padding to the floating window
  float = { border = 'solid' },
})

-- Enable tree-sitter based folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

require('colors')
require('config.lazy')


--[[
Key bindings and custom commands from here

key bindings used by plugins:
* <CR> in normal mode
* <CR> in visual mode
* <BS> in normal mode
--]]

local noremap = { noremap = true }

-- Disable some default key bindings
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', noremap) -- <Space> is used as the leader
vim.api.nvim_set_keymap('n', '(', '<Nop>', noremap)
vim.api.nvim_set_keymap('n', ')', '<Nop>', noremap)
vim.api.nvim_set_keymap('n', '[d', '<Nop>', noremap)
vim.api.nvim_set_keymap('n', ']d', '<Nop>', noremap)
vim.api.nvim_set_keymap('n', 'gd', '<Nop>', noremap)
vim.api.nvim_set_keymap('n', 'gr', '<Nop>', noremap)
vim.api.nvim_set_keymap('n', 's', '<Nop>', noremap)

-- Common key bindings
-- vim.api.nvim_set_keymap('n', '<Left>', '10h', noremap)
-- vim.api.nvim_set_keymap('n', '<Right>', '10l', noremap)
vim.api.nvim_set_keymap('n', 'H', '^', noremap)
vim.api.nvim_set_keymap('v', 'H', '^', noremap)
vim.api.nvim_set_keymap('n', 'L', '$', noremap)
vim.api.nvim_set_keymap('v', 'L', '$', noremap)
vim.api.nvim_set_keymap('n', 'p', ']p', noremap)
vim.api.nvim_set_keymap('n', 'P', '[p', noremap)
vim.api.nvim_set_keymap('n', 's', 'F', noremap)
vim.api.nvim_set_keymap('n', '<C-s>', '`.', noremap) -- Move to the position where the last change was made
vim.api.nvim_set_keymap('n', '<leader>/', ':noh<CR>', noremap) -- Stop highlighting search hits
vim.api.nvim_set_keymap('i', '<S-Enter>', '<Esc>O', noremap)

-- LSP client key bindings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, noremap)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, noremap)
vim.keymap.set('n', '<leader>g', vim.lsp.buf.hover, noremap)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, noremap)
vim.keymap.set('n', 'g<C-d>', ':split | lua vim.lsp.buf.definition()<CR>', noremap)
vim.keymap.set('n', '<F2>', ':lua vim.lsp.buf.rename()<CR>', noremap)

-- Window key bindings
-- Go to last accessed window
vim.api.nvim_set_keymap('n', '<leader><Space>', '<C-w>p', noremap)
-- window navigation
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', noremap)
vim.api.nvim_set_keymap('n', '<leader>n', '<C-w>j', noremap)
vim.api.nvim_set_keymap('n', '<leader>e', '<C-w>k', noremap)
vim.api.nvim_set_keymap('n', '<leader>i', '<C-w>l', noremap)
-- Close the window
vim.api.nvim_set_keymap('n', '<leader>x', '<C-w>q', noremap)
-- Resize the window
vim.api.nvim_set_keymap('n', '<C-->', ':vertical resize -5<CR>', noremap)
vim.api.nvim_set_keymap('n', '<C-=>', ':vertical resize +5<CR>', noremap)
vim.api.nvim_set_keymap('n', '(', ':resize -3<CR>', noremap)
vim.api.nvim_set_keymap('n', ')', ':resize +3<CR>', noremap)

-- Folding key bindings
vim.api.nvim_set_keymap('n', '<leader>a', 'za', noremap)
vim.api.nvim_set_keymap('n', '<leader>A', 'zA', noremap)
vim.api.nvim_set_keymap('n', '<leader>z', 'zR', noremap)
vim.api.nvim_set_keymap('n', '<leader>Z', 'zM', noremap)

-- Telescope key bindings
local tele_builtin = require('telescope.builtin')
local tele_conf = require('config.telescope')
vim.keymap.set('n', '<leader>f', tele_conf.pick_files, noremap)
vim.keymap.set('n', '<leader>t', tele_builtin.help_tags, noremap)
vim.keymap.set('n', '<leader>p', tele_builtin.registers, noremap)
vim.keymap.set('n', '<leader>b', tele_builtin.buffers, noremap)
--[[
usage note of telescope

To use a picker that does not have a keyboard shortcut, enter :Telescope in the
command line followed by the picker's name.

Press <C-/> to view key mappings for picker actions. Below is a list of common
operations.

* Press <C-X> to open the file in horizontal split
* Press <C-V> to open the file in vertical split
--]]

-- Custom commands
vim.api.nvim_create_user_command('Q', 'wqa', {})
-- Copy the entire buffer
vim.api.nvim_create_user_command('A', 'normal ggVGy', {})

-- Auto commands
-- Remove trailing whitespace
vim.api.nvim_create_autocmd(
  { 'BufWritePre' },
  {
    pattern = { '*' },
    command = [[%s/\s\+$//e]],
  }
)
