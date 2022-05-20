-- overriding default plugin configs

local M = {}

M.treesitter = {
   ensure_installed = {
      "html",
      "css",
      "javascript",
      "json",
      "toml",
      "markdown",
      "bash",
      "lua",
      "python",
      "go",
   },
}

M.nvimtree = {
   git = {
      enable = true,
   },
}

return M
