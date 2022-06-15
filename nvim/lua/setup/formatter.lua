-- formatter.lua

-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format and FormatWrite commands
require("formatter").setup({
	-- All formatter configurations are opt-in
	filetype = {
		python = {
			function()
				return {
					exe = "darker",
					args = {
						"-i",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
				}
			end,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		go = {
			require("formatter.filetypes.go").gofmt,
		},
		css = {
			require("formatter.filetypes.css").prettier,
		},
		html = {
			require("formatter.filetypes.html").prettier,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettier,
		},
	},
})
