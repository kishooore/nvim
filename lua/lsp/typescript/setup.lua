local nvim_lsp = require('lspconfig')
local keybindings = require('lsp.common.keybindings')
local auto_complete = require('lsp.common.auto-complete')
local lspkind = require('lsp.common.lspkind')
local lspsaga = require('lsp.common.lspsaga')

local on_attach = function(client, bufnr)
  keybindings.setup()
  auto_complete.setup()
  lspkind.setup()
  lspsaga.setup()
end

nvim_lsp.tsserver.setup {
  on_attach = on_attach
}

