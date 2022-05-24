return {
  ["wakatime/vim-wakatime"] = {},

  ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
  },

  ["goolord/alpha-nvim"] = {
      disable = false,
  },
}
