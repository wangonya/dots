local reset_group = vim.api.nvim_create_augroup("reset_group", {
	clear = false,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "FocusGained" }, {
	callback = function()
		if vim.fn.isdirectory(".git") ~= 0 then
			-- always runs in the current directory, rather than in the buffer's directory
			local branch = vim.fn.system("git branch --show-current | tr -d '\n'")
			vim.b.branch_name = " [" .. branch .. "] "
		end
	end,
	group = init_group,
})

vim.opt.laststatus = 3 -- use global statusline
vim.opt.statusline =
	[[%#LineNr#%{get(b:, "branch_name", "")} %t %m %= %{&fileencoding?&fileencoding:&encoding} [%{&fileformat}] %p%% %l:%c]]
