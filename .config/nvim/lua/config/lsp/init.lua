local M = {}

local servers = {
  gopls = {},
  html = {},
  jsonls = {},
  pyright = {},
  rust_analyzer = {},
  sumneko_lua = {},
  tsserver = {},
  vimls = {},
}


local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)
end

-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()) -- for nvim-cmp

-- 

local lsp_flags = {
  debounce_text_changes = 150,
}

local lspconfig = require "lspconfig"
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

function M.setup()

  --[[
  lspconfig.beancount.setup{
    single_file_support = true,
    flags = lsp_flags,
    init_options = {
      journal_file = "~/db/beancount/my/cash.bean"
    }
  }
  --]]

  lspconfig.sumneko_lua.setup{
    single_file_support = true,
    on_attach = on_attach,
    flags = lsp_flags,
  }
  -- require("config.lsp.installer").setup(servers, opts)
end

return M
