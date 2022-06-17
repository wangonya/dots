-- bufferline setup

require("bufferline").setup({
	options = {
		modified_icon = "·",
		always_show_bufferline = false,
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
