local dap = require("dap")
dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}

-- dap.configurations.python = {
-- 	{
-- 		-- The first three options are required by nvim-dap
-- 		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
-- 		request = "launch",
-- 		name = "Launch file",
-- 		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
-- 		program = "${file}", -- This configuration will launch the current file if used.
-- 		pythonPath = function()
-- 			--The below line will work for virtualenvwrapper, as vim.env.VIRTUAL_ENV points to the active env directory if you use it
-- 			--Test the variable by running :lua print(vim.env.VIRTUAL_ENV) and find your path from there if it is defined
-- 			if vim.env.VIRTUAL_ENV then
-- 				return vim.env.VIRTUAL_ENV .. "/bin/python"
-- 			end
-- 			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
-- 			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
-- 			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable (done above).
-- 			local cwd = vim.fn.getcwd()
-- 			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
-- 				return cwd .. "/venv/bin/python"
-- 			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
-- 				return cwd .. "/.venv/bin/python"
-- 			else
-- 				return "/usr/bin/python"
-- 			end
-- 		end,
-- 	},
-- }
