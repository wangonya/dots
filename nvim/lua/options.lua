--[[ opts.lua ]]

local g = vim.g
local wo = vim.wo
local opt = vim.opt
local cmd = vim.cmd
local exec = vim.api.nvim_exec

g.mapleader = " "
g.autoread = true

wo.number = false
wo.cursorline = false

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

-- session save
cmd([[
augroup SessionSave
    autocmd!
    autocmd VimLeave * mksession! .session.vim
augroup end
]])

-- reload neovim when plugins config is saved
cmd([[
  augroup PluginsReload
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
  augroup end
]])

-- reload bspwm when config is saved
cmd([[
  augroup WmReload
    autocmd!
    autocmd BufWritePost bspwmrc !install -Dm755 ~/dots/bspwm/bspwmrc ~/.config/bspwm/bspwmrc && bspc wm -r
  augroup end
]])

-- reload sxhkd when config is saved
cmd([[
  augroup SxhkdReload
    autocmd!
    autocmd BufWritePost sxhkdrc !install -Dm755 ~/dots/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc && pkill -USR1 -x sxhkd
  augroup end
]])
