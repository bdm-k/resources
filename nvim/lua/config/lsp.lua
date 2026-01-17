local capabilities = require('blink.cmp').get_lsp_capabilities()
local ok, servers = pcall(require, 'config.lang-servers')
local servers = ok and servers or {}

vim.lsp.config('*', {
  capabilities = capabilities,
})

for server, config in pairs(servers) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
