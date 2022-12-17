-- local lsp_installer_servers = require "nvim-lsp-installer.servers"
-- local utils = require "utils"

local msn = require("mason")

local M = {}

function M.setup()
  msn.setup({
      ui = {
          icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
          }
      }
  })
end

return M
