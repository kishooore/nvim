local lspsaga = require('lspsaga')

local M = {}

function M.setup()

  lspsaga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    border_style = "round",
  }

end

return M

