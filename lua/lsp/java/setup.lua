local keybindings = require('lsp.common.keybindings')
local auto_complete = require('lsp.common.auto-complete')
local lspkind = require('lsp.common.lspkind')
local lspsaga = require('lsp.common.lspsaga')
local M = {}

function M.setup()
  local on_attach = function(client, bufnr)
    keybindings.setup()
    auto_complete.setup()
    lspkind.setup()
    lspsaga.setup()

    -- setup debugger
    require'jdtls'.setup_dap({ hotcodereplace = 'auto' })
--    require'jdtls'.setup_dap()
    require'jdtls.setup'.add_commands()

--    require'formatter'.setup{
--      filetype = {
--        java = {
--          function()
--            return {
--              exe = 'java',
--              args = { '-jar', os.getenv('HOME') .. '/.config/nvim/lsp/java/google-java-format-1.11.0-all-deps.jar', vim.api.nvim_buf_get_name(0) },
--              stdin = true
--            }
--          end
--        }
--      }
--    }

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    
    -- Mappings
    local opts = { noremap=true, silent=true }
    -- Java specific
    vim.cmd("command! LspOrganizeJavaImports lua require'jdtls'.organize_imports()")
    vim.cmd("command! LspTestClass lua require'jdtls'.test_class()<CR>")
    vim.cmd("command! LspTestNearest lua require'jdtls'.test_nearest_method()<CR>")
    vim.cmd("command! LspExtractVariable lua require('jdtls').extract_variable(true)<CR>")
    vim.cmd("command! LspExtractMethod lua require('jdtls').extract_method(true)<CR>")
    vim.cmd("command! LspCodeAction lua require('jdtls').code_action()<CR>")

    buf_set_keymap("n", "<leader>di", ":LspOrganizeJavaImports<CR>", opts)
    buf_set_keymap("n", "<leader>tc", ":LspTestClass<CR>", opts)
    buf_set_keymap("n", "<leader>tn", ":LspTestNearest<CR>", opts)
    buf_set_keymap("v", "<leader>ev", ":LspExtractVariable<CR>", opts)
    buf_set_keymap("v", "<leader>em", ":LspExtractMethod<CR>", opts)
    ---buf_set_keymap("n", "<leader>ca", ":LspJavaCodeAction<CR>", opts)
    ---buf_set_keymap("n", "<leader>cf", ":LspJavaFormatting<CR>", opts)

    
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
  local home = os.getenv('HOME')
  local root_markers = {'gradlew', 'pom.xml'}
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local config = {
    flags = {
      allow_incremental_sync = true,
    },
    on_attach = on_attach
  }
  config.settings = {
    java = {
      completion = {
        favoriteStaticMembers = {
          "org.mockito.Mockito.*",
          "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
          "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*"
        }
      }
    }
  }
  config.cmd = {'launch_jdtls', workspace_folder}
  local bundles = {
    vim.fn.glob("$HOME/.config/nvim/lsp/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
  };

  vim.list_extend(bundles, vim.split(vim.fn.glob("$HOME/.config/nvim/lsp/java/vscode-java-test/server/*.jar"), "\n"))

  local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  config.init_options = {
    bundles = bundles;
    extendedClientCapabilities = extendedClientCapabilities;
  }

  -- UI
  local finders = require'telescope.finders'
  local sorters = require'telescope.sorters'
  local actions = require'telescope.actions'
  local pickers = require'telescope.pickers'
  require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
    local opts = {}
    pickers.new(opts, {
      prompt_title = prompt,
      finder    = finders.new_table {
        results = items,
        entry_maker = function(entry)
          return {
            value = entry,
            display = label_fn(entry),
            ordinal = label_fn(entry),
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)

          cb(selection.value)
        end)

        return true
      end,
    }):find()
  end

  require('jdtls').start_or_attach(config)
end

return M
