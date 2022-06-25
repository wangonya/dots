-- formatter.lua

require("formatter").setup({
	filetype = {
		python = {
			require("formatter.filetypes.python").black,
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
