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
      config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end,
  },
}
