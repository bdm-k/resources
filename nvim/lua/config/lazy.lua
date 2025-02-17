local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
-- Install lazy.nvim if it's not installed yet
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')
lazy.setup({
  spec = {
    {
      'echasnovski/mini.nvim',
      version = false, -- Use the main branch
      config = function()
        -- When adding surrounding brackets, use closing ones if you do not want
        -- whitespace padding.
        require('mini.surround').setup()

        require('mini.pairs').setup()

        -- To stage the hunk within which the cursor is located, type 'ghgh'.
        require('mini.diff').setup({
          view = {
            style = 'sign',
            signs = { add = '▕', change = '▕', delete = '▕' },
          },
          delay = { text_change = 1000 },
          mappings = {
            goto_first = '',
            goto_last = '',
            goto_prev = '<C-[>',
            goto_next = '<C-]>',
          },
        })
        local palette = require('colors')
        vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { fg = palette.secondary })
        vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = palette.orange })
        vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { fg = palette.primary })
      end
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
          ensure_installed = {
            'json',
            'jsonc',
          },

          highlight = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<CR>',
              node_incremental = '<CR>',
              node_decremental = '<BS>',
            },
          },
        })
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('config.lualine').setup()
      end,
    },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',
        'sharkdp/fd',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
      config = function()
        require('config.telescope').setup()
      end,
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      version = "*", -- Install the latest stable version
      config = function()
        require("telescope").load_extension "frecency"
      end,
    },
    {
      'neovim/nvim-lspconfig',
      config = function()
        local lspconfig = require 'lspconfig'
        -- lspconfig.clangd.setup {}
        -- lspconfig.tsserver.setup {}
        -- lspconfig.rust_analyzer.setup {}
      end,
    },
  }
})
