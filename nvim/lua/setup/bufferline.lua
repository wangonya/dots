-- bufferline setup

require("bufferline").setup({
	options = {
		modified_icon = "·",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})
