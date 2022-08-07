-- telescope setup

local actions = require("telescope.actions")

require("telescope").setup({
	pickers = {
		find_files = {
			theme = "dropdown",
			sort_lastused = true,
			previewer = false,
		},
		buffers = {
			show_all_buffers = true,
			previewer = false,
			theme = "dropdown",
			sort_lastused = true,
			mappings = {
				i = {
					["<c-r>"] = actions.delete_buffer,
				},
			},
		},
	},
})
