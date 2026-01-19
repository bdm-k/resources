local tele = require('telescope')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')

local previewer = function()
  return previewers.new_termopen_previewer({
    title = '  Git File Difftastic Preview',

    get_command = function(entry)
      local command = { 'git diff' }
      if entry.status and (entry.status == "??" or entry.status == "A ") then
        table.insert(command, '--no-index /dev/null')
      else
        table.insert(command, 'HEAD --')
      end
      table.insert(command, entry.value)

      table.insert(command, '| less -R')

      return { 'sh', '-c', table.concat(command, ' ') }
    end,
  })
end

local picker = function(opts)
  opts = opts or {}
  opts.previewer = previewer()
  opts.prompt_title = '  Git Status'
  builtin.git_status(opts)
end

return tele.register_extension {
  exports = {
    picker = picker,
  },
}
