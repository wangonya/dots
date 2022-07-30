-- mappings.lua

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--
map("n", "<C-s>", ":wa<CR>")

-- nvim-tree
map("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true })
map("n", "<leader>r", ":NvimTreeRefresh<CR>", { silent = true })

-- diffview
map("n", "<leader>do", ":DiffviewOpen<CR>", { silent = true })
map("n", "<leader>dc", ":DiffviewClose<CR>", { silent = true })

-- debugger
map("n", "<leader>do", ":lua require('dapui').toggle()<cr>")
map("n", "<f5>", ":lua require('dap').toggle_breakpoint()<cr>")
map("n", "<f9>", ":lua require('dap').continue()<cr>")

map("n", "<F1>", ":lua require('dap').step_over()<CR>")
map("n", "<F2>", ":lua require('dap').step_into()<CR>")
map("n", "<F3>", ":lua require('dap').step_out()<CR>")

map("n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>")
map("v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>")

map("n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
map("n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>")

map("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>")
map("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>")

map("n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>")

map("n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>")
