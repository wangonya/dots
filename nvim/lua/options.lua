--[[ opts.lua ]]

local g = vim.g
local opt = vim.opt
local cmd = vim.api.nvim_command
local exec = vim.api.nvim_exec

g.mapleader = " "

opt.termguicolors = true
opt.mouse = "a"

exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]],
	true
)
