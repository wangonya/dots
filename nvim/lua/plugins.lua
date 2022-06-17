-- plugins.lua

function get_setup(name)
	return string.format('require("setup/%s")', name)
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
		},
		config = get_setup("lsp"),
	})

	-- formatting
	use({ "mhartington/formatter.nvim", config = get_setup("formatter") })

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = get_setup("telescope"),
	})

	-- theme
	use({
		"wangonya/xresources-nvim",
		config = get_setup("xresources-nvim"),
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
end)
