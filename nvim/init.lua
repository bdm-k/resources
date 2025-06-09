--[[
Tier 1 commands:

* '%': Moves the cursor to the matching character.

* 'zt', 'zz', 'zb': These commands make the current line at the top, center, or
  bottom of the window, respectively.

Tier 2 commands:

* '`0': Jumps to the position of the cursor when you last exited Neovim. Here,
  '0' is a numbered mark. Likewise, '1' denotes the second to last position, and
  so on.

* '`"': Jumps to where the cursor was in the current buffer when you last exited
  Neovim.

* 'gx': open the URL at cursor
--]]

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

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


------------------
-- Key bindings --
------------------
--[[
Several key bindings used by plugins:
* <CR> in normal and visual mode
* <BS> in normal and visual mode
* <C-[> and <C-]> in normal mode
--]]

local noremap = { noremap = true }

--
-- Common key bindings
--
vim.api.nvim_set_keymap('n', 'H', '^', noremap)
vim.api.nvim_set_keymap('v', 'H', '^', noremap)
vim.api.nvim_set_keymap('n', 'L', '$', noremap)
vim.api.nvim_set_keymap('v', 'L', '$', noremap)
vim.api.nvim_set_keymap('n', 'p', ']p', noremap)
vim.api.nvim_set_keymap('n', 'P', '[p', noremap)
vim.api.nvim_set_keymap('n', 'n', '<Cmd>keepjumps normal! n<CR>', noremap)
vim.api.nvim_set_keymap('n', 'N', '<Cmd>keepjumps normal! N<CR>', noremap)
vim.api.nvim_set_keymap('n', '-', '<C-o>', noremap) -- Navigate back jump list
vim.api.nvim_set_keymap('n', '=', '<C-i>', noremap) -- Navigate forward jump list
vim.api.nvim_set_keymap('n', '<C-s>', '`.', noremap) -- Move to the position where the last change was made
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', noremap) -- Stop highlighting search hits
vim.api.nvim_set_keymap('i', '<S-Enter>', '<Esc>O', noremap) -- Enable beginning a new line above the cursor in the insert mode

--
-- LSP client key bindings
--
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, noremap)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, noremap)
vim.keymap.set('n', '<leader>g', vim.lsp.buf.hover, noremap)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, noremap)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, noremap)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, noremap)
vim.keymap.set('n', 'g<C-d>', ':split | lua vim.lsp.buf.definition()<CR>', noremap)
vim.keymap.set('n', '<F2>', ':lua vim.lsp.buf.rename()<CR>', noremap)
--[[
usage notes for LSP

You can stop all langage servers with :LspStop. Conversely, to restart all stopped
language servers, use :LspStart.
--]]

--
-- Window key bindings
--
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

--
-- Folding key bindings
--
vim.api.nvim_set_keymap('n', '<leader>a', 'za', noremap)
vim.api.nvim_set_keymap('n', '<leader>A', 'zA', noremap)
vim.api.nvim_set_keymap('n', '<leader>z', 'zR', noremap) -- Open all folds
vim.api.nvim_set_keymap('n', '<leader>Z', 'zM', noremap)

--
-- Telescope key bindings
--
local tele_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', tele_builtin.live_grep, noremap)
vim.keymap.set('n', '<leader>p', ':Telescope frecency workspace=CWD<CR>', noremap)
vim.keymap.set('n', '<leader>t', tele_builtin.help_tags, noremap)
vim.keymap.set('n', '<leader>b', tele_builtin.buffers, noremap)
vim.keymap.set('n', '<leader>r', tele_builtin.resume, noremap)
--[[
usage notes for Telescope

To use a picker that does not have a keyboard shortcut, enter :Telescope in the
command line followed by the picker's name.

Press <C-/> to view key mappings for picker actions. Below is a list of common
operations.

* Press <C-X> to open the file in horizontal split
* Press <C-V> to open the file in vertical split
--]]


---------------------
-- Custom commands --
---------------------
vim.api.nvim_create_user_command('Q', 'wqa', {})

-- Copy the entire buffer
vim.api.nvim_create_user_command('C', 'normal ggVGy', {})

vim.api.nvim_create_user_command('O', 'lua MiniDiff.toggle_overlay()', {})

-- Toggle the line wrap
vim.api.nvim_create_user_command('W', function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, {})

-- Toggle the inlay hints
vim.api.nvim_create_user_command('H', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})


-------------------
-- Auto commands --
-------------------
-- Remove trailing whitespace
vim.api.nvim_create_autocmd(
  { 'BufWritePre' },
  {
    pattern = { '*' },
    command = [[%s/\s\+$//e]],
  }
)
