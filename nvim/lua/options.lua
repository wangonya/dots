--[[ opts.lua ]]

vim.g.mapleader = " "
vim.g.autoread = true

vim.wo.number = true
vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"
vim.wo.foldlevel = 99
vim.wo.foldenable = true

vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd([[colorscheme nord]])

vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]],
	true
)

vim.api.nvim_exec(
	[[
augroup SessionSave
    autocmd!
    autocmd VimLeave * mksession! .session.vim
augroup END
]],
	true
)
