-- mappings.lua

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- ?
map("n", "<C-s>", ":wa<CR>")

-- nvim-tree
map("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true })
map("n", "<leader>r", ":NvimTreeRefresh<CR>", { silent = true })
