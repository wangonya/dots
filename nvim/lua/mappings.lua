-- mappings.lua

local map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--
map("n", "<C-s>", ":w<CR>")

-- files tree
map("n", "<leader>t", ":! rg --files | tree --fromfile<CR>", { silent = true })

-- telescope
map("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", { silent = true })
map("n", "<leader>s", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { silent = true })
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", { silent = true })
map("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<cr>", { silent = true })
map("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>", { silent = true })
map("n", "<leader>gh", "<cmd>lua require('telescope.builtin').git_stash()<cr>", { silent = true })
map("n", "<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", { silent = true })

-- debugger
map("n", "<leader>dbt", ":lua require('dapui').toggle()<cr>")
map("n", "<f5>", ":lua require('dap').toggle_breakpoint()<cr>")
map("n", "<f9>", ":lua require('dap').continue()<cr>")

map("n", "<F1>", ":lua require('dap').step_over()<CR>")
map("n", "<F2>", ":lua require('dap').step_into()<CR>")
map("n", "<F3>", ":lua require('dap').step_out()<CR>")
