return {

	-- my plugins

	["wakatime/vim-wakatime"] = {},

	["mfussenegger/nvim-dap"] = {
		config = function()
			require("custom.plugins.dap")
		end,
	},

	["rcarriga/nvim-dap-ui"] = {
		after = "nvim-dap",
		config = function()
			require("dapui").setup()
		end,
	},

	-- plugins below come with NVChad

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
