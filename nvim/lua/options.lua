--[[ opts.lua ]]

local g = vim.g
local wo = vim.wo
local opt = vim.opt
local exec = vim.api.nvim_exec
local cmd = vim.cmd

g.mapleader = " "
g.autoread = true

cmd("colorscheme base16-grayscale-dark")

wo.number = true
wo.cursorline = true
wo.cursorlineopt = "number"

opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
opt.foldnestmax = 3
opt.foldminlines = 1
opt.termguicolors = true
opt.mouse = "a"
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
