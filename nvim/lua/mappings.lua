-- mappings.lua

local map = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--
map("n", "<C-s>", ":w<cr>")
map("n", "<C-t>", ":term<cr>")

-- files tree
map("n", "<leader>t", ":! rg --files | tree --fromfile<cr>")

-- telescope
map("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>s", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<cr>")
map("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>")
map("n", "<leader>gh", "<cmd>lua require('telescope.builtin').git_stash()<cr>")
map("n", "<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<cr>")

-- debugger
map("n", "<leader>dbt", ":lua require('dapui').toggle()<cr>")
map("n", "<f5>", ":lua require('dap').continue()<cr>")
map("n", "<f9>", ":lua require('dap').toggle_breakpoint()<cr>")
map("n", "<f10>", ":lua require('dap').step_over()<cr>")
map("n", "<f11>", ":lua require('dap').step_into()<cr>")
map("n", "<f12>", ":lua require('dap').step_out()<cr>")
