-- treesitter setup

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"html",
		"css",
		"javascript",
		"json",
		"toml",
		"markdown",
		"bash",
		"lua",
		"python",
		"go",
	},
	highlight = { enable = true },
	indent = { enable = true },
})
