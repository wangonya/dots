-- bufferline setup

require("bufferline").setup({
	options = {
		modified_icon = "·",
		always_show_bufferline = false,
		show_close_icon = false,
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
