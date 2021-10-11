local M = {}

function M.setup()

  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  vim.cmd("command! LspFinder lua require'lspsaga.provider'.lsp_finder()")
  vim.cmd("command! LspTerminal lua require'lspsaga.floaterm'.open_float_terminal()")

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', ':LspDeclaration<CR>', opts)
  buf_set_keymap('n', 'gd', ':LspDef<CR>', opts)
  buf_set_keymap('n', 'gi', ':LspImplementation<CR>', opts)
  buf_set_keymap('n', 'gr', ':LspRefs<CR>', opts)
  buf_set_keymap('n', 'K', ':LspHover<CR>', opts)
  buf_set_keymap('n', '<C-k>', ':LspSignatureHelp<CR>', opts)
  buf_set_keymap('n', 'gh', ':Lspsaga lsp_finder<CR>', opts)
  buf_set_keymap('n', 'ca', ':LspCodeAction<CR>', opts)
  buf_set_keymap('n', 'nd', ':LspDiagNext<CR>', opts)
  buf_set_keymap('n', 'pd', ':LspDiagPrev<CR>', opts)
  buf_set_keymap('n', 'rn', ':LspRename<CR>', opts)
end

return M
