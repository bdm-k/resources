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
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
          ensure_installed = {
            'typescript',
            'rust',
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
      lazy = false,
      dependencies = {
        { 'ms-jpq/coq_nvim', branch = 'coq' },
        { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
        { 'ms-jpq/coq.thirdparty', branch = '3p' },
      },
      init = function()
        vim.g.coq_settings = {
          auto_start = true,
          display = {
            statusline = { helo = false },
            preview = {
              border = 'solid',
            },
          },
        }
      end,
      config = function()
        local lspconfig = require 'lspconfig'
        local coq = require 'coq'
        -- lspconfig.tsserver.setup(coq.lsp_ensure_capabilities {})
        lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities {})
      end,
    },
    {
      'Shatur/neovim-session-manager',
      enabled = false,
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local session_manager_config = require('session_manager.config')
        require('session_manager').setup({
          autoload_mode = session_manager_config.AutoloadMode.CurrentDir,
        })
      end,
    },
  }
})
