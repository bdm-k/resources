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

        require('mini.icons').setup() -- used by blink.cmp
        require('mini.snippets').setup() -- integrated into blink.cmp
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
            'nix',
            'bash',
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
        require('config.lualine').setup_wo_diagnostic()
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
      'saghen/blink.cmp',
      version = '*',
      build = 'cargo build --release', -- requires nightly toolchain

      --@module 'blink.cmp'
      --@type blink.cmp.Config
      opts = {
        -- See https://cmp.saghen.dev/configuration/keymap#enter for the preset
        -- key bindings.
        keymap = {
          preset = 'enter',
          ['<C-p>'] = { 'cancel', 'fallback' }, -- Hides the completion menu
          ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
          ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        },

        completion = {
          list = {
            selection = {
              -- Do not automatically select the first item in the completion list
              -- for command-line mode.
              preselect = function(ctx) return ctx.mode ~= 'cmdline' end,
            },
          },
          menu = {
            draw = {
              components = {
                -- Use mini.icons
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                    return kind_icon
                  end,
                  highlight = function(ctx)
                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    return hl
                  end,
                },
                label = {
                  width = { max = 45 },
                },
              },
            },
          },
        },

        snippets = { preset = 'mini_snippets' },

        sources = {
          -- In command-line mode, hide the completion menu until 3 letters are
          -- typed.
          min_keyword_length = function(ctx)
            if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
              return 3
            end
            return 0
          end,
        },

        signature = { enabled = true },
      },
    },
  }
})
