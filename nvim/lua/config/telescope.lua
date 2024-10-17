local M = {}

local builtin = require('telescope.builtin')


-- Cache for the pick_files
local is_inside_work_tree = {}

-- pick_files: If cwd is in a git reposity, use 'git_files', otherwise use 'find_files'
M.pick_files = function()
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system('git rev-parse --is-inside-work-tree')
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files()
  else
    builtin.find_files()
  end
end


-- The setup function
M.setup = function()
  local tele = require('telescope')

  tele.setup {
    defaults = {
      borderchars = { '-', '╎', '-', '╎', '+', '+', '+', '+' },
      layout_config = { width = 0.9, preview_width = 0.6 },
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
