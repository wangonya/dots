-- debugger setup

require("dap.ext.vscode").load_launchjs()

local dap = require("dap")

-- python

require("dap-python").setup("/usr/bin/python")

--[[ function get_venv()
	local cwd = vim.fn.getcwd()
	if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		return cwd .. "/venv/bin/python"
	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	else
		return "/usr/bin/python"
	end
end

dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		name = "Launch file",
		type = "python",
		request = "launch",
		program = "${file}",
		pythonPath = get_venv(),
		subProcess = false,
	},
	{
		name = "Attach",
		type = "python",
		request = "attach",
		port = function()
			local val = tonumber(vim.fn.input("Port: ", "5005"))
			assert(val, "Please provide a port number")
			return val
		end,
		pythonPath = get_venv(),
	},
} ]]

-- processId = require("dap.utils").pick_process,
-- go setup: https://pepa.holla.cz/2022/02/02/debugging-go-in-neovim/

-- dap ui
require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
	},
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				-- "stacks",
				"watches",
			},
			size = 40,
			position = "right",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
})

-- dap virtual text
require("nvim-dap-virtual-text").setup()
