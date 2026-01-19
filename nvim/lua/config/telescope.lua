local M = {}

-- The setup function
M.setup = function()
  local tele = require('telescope')
  local actions = require('telescope.actions')

  tele.setup {
    defaults = {
      borderchars = { '-', '╎', '-', '╎', '+', '+', '+', '+' },
      layout_config = {
        width = 0.9,
        preview_cutoff = 140,
        preview_width = 0.5,
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
      },
    },
    pickers = {
      buffers = {
        mappings = {
          i = { ['<S-BS>'] = 'delete_buffer' },
        },
      },
    },
    extensions = {
      -- Speed up sorting
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
      },
    },
  }

  tele.load_extension('fzf')
end

return M
