
local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

   -- webdev stuff
   b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } },

   -- Lua
   b.formatting.stylua,

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   -- python
   b.formatting.black,
   b.formatting.isort,

   -- go
   b.formatting.gofmt,
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,
   }
end

return M
