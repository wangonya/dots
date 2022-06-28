--[[ opts.lua ]]

local g = vim.g
local wo = vim.wo
local opt = vim.opt
local exec = vim.api.nvim_exec

g.mapleader = " "
g.autoread = true

wo.number = true
wo.cursorline = true
wo.cursorlineopt = "number"
wo.foldlevel = 99
wo.foldenable = true

opt.termguicolors = true
opt.mouse = "a"
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.clipboard = "unnamedplus"
opt.completeopt = "menuone,noinsert"
opt.signcolumn = "yes"
opt.shortmess = "F"

exec(
	[[
augroup SessionSave
    autocmd!
    autocmd VimLeave * mksession! .session.vim
augroup END
]],
	true
)
