vim.opt.number = true
vim.opt.relativenumber = true

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
vim.api.nvim_set_keymap('n', '<Left>', '10h', noremap)
vim.api.nvim_set_keymap('n', '<Right>', '10l', noremap)
vim.api.nvim_set_keymap('n', 'p', ']p', noremap)
vim.api.nvim_set_keymap('n', 'P', '[p', noremap)
vim.api.nvim_set_keymap('n', 's', 'F', noremap)
vim.api.nvim_set_keymap('i', '<S-Enter>', '<Esc>O', noremap)

-- LSP client key bindings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, noremap)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, noremap)
vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, noremap) -- mnemonic: inspect
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, noremap)
vim.keymap.set('n', 'g<C-d>', ':split | lua vim.lsp.buf.definition()<CR>', noremap)
vim.keymap.set('n', '<F2>', ':lua vim.lsp.buf.rename()<CR>', noremap)

-- Window key bindings
vim.api.nvim_set_keymap('n', '<leader><Space>', '<C-w>p', noremap)
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', noremap)
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', noremap)
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', noremap)
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', noremap)
vim.api.nvim_set_keymap('n', '<leader>e', '<C-w>q', noremap)
vim.api.nvim_set_keymap('n', '<C-[>', ':vertical resize -10<CR>', noremap)
vim.api.nvim_set_keymap('n', '<C-]>', ':vertical resize +10<CR>', noremap)
vim.api.nvim_set_keymap('n', '(', ':resize -10<CR>', noremap)
vim.api.nvim_set_keymap('n', ')', ':resize +10<CR>', noremap)

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
vim.api.nvim_set_keymap('n', 'H', '^', noremap)
vim.api.nvim_set_keymap('n', 'L', '$', noremap)
vim.api.nvim_set_keymap('i', '<S-Enter>', '<Esc>O', noremap)
vim.api.nvim_set_keymap('n', 'p', ']p', noremap)
vim.api.nvim_set_keymap('n', 'P', '[p', noremap)

-- Custom commands
vim.api.nvim_create_user_command('Q', 'wqa', {})

-- Auto commands
-- Remove trailing whitespace
vim.api.nvim_create_autocmd(
  { 'BufWritePre' },
  {
    pattern = { '*' },
    command = [[%s/\s\+$//e]],
  }
)
