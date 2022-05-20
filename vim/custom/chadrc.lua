local M = {}
local override = require "custom.plugins.override"

M.ui = {
   theme = "onedark",
}

M.plugins = {
  options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },

      statusline = {
         separator_style = "block",
      },
   },

   override = {
      ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
      ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
   },

   user = require "custom.plugins"
}

return M
