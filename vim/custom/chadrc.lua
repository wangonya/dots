local M = {}
local override = require "custom.plugins.override"

M.ui = {
  theme = "darker",
}

M.plugins = {
  options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
      statusline = {
         separator_style = "block", -- default/round/block
      },
   },

   override = {
      ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
      ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
   },

   user = require "custom.plugins"
}

return M
