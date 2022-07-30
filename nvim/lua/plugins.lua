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
	-- file tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = get_setup("nvim-tree"),
	})

	-- statusline
	use({
		"nvim-lualine/lualine.nvim",
		config = get_setup("lualine"),
	})

	-- bufferline
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
		config = get_setup("bufferline"),
	})

	-- wakatime
	use({
		"wakatime/vim-wakatime",
	})

	-- lsp
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/nvim-lsp-installer" },

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
		requires = { "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap-python" },
		config = get_setup("debugger"),
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

	-- dashboard
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = get_setup("dash"),
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

	-- diffview
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	-- indent guides
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = get_setup("indent-blankline"),
	})

	-- theme
	use({ "catppuccin/nvim", as = "catppuccin", config = get_setup("theme") })

	-- terminal
	use({
		"akinsho/toggleterm.nvim",
		config = get_setup("terminal"),
	})

	-- colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		config = get_setup("colorizer"),
	})
end)
