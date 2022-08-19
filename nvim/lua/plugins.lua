-- plugins.lua

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

-- Install Plugins

function get_setup(name)
	return string.format('require("plugins-config/%s")', name)
end

return require("packer").startup(function()
	-- lsp
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- Formatting
			{ "jose-elias-alvarez/null-ls.nvim" },
		},
		config = get_setup("lsp"),
	})

	-- debugger
	use({
		"mfussenegger/nvim-dap",
		requires = { "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui" },
		config = get_setup("debugger"),
	})
	use({
		"mfussenegger/nvim-dap-python",
		branch = "multi-session", -- https://github.com/mfussenegger/nvim-dap-python/pull/21
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = get_setup("telescope"),
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = get_setup("treesitter"),
	})

	-- parens
	use({
		"windwp/nvim-autopairs",
		config = get_setup("autopairs"),
	})

	-- commentary
	use("b3nj5m1n/kommentary")

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		config = get_setup("gitsigns"),
	})

	-- indent guides
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = get_setup("indent-blankline"),
	})

	-- theme
	use({
		"wangonya/base16-black-metal-immortal.vim",
		config = get_setup("theme"),
	})

	-- highlight todos
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = get_setup("todos"),
	})
	-- TODO: fix this

	-- colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		config = get_setup("colorizer"),
	})
end)
