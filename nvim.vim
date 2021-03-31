call plug#begin('~/.config/nvim/plugged')
Plug 'wakatime/vim-wakatime'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-startify'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tell-k/vim-autopep8'
Plug 'junegunn/goyo.vim'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'
Plug 'tweekmonster/django-plus.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
call plug#end()

colorscheme dracula

" don't need vi
set nocompatible

" allow hidden buffer
set hidden

" leader key
let mapleader = ","

" set relative line numbers
set relativenumber

" blink cursor on error instead of beeping
set visualbell

" encoding
set encoding=utf-8

" always set spell on for .md files
autocmd BufRead,BufNewFile *.md setlocal spell

" show command in bottom bar
set showcmd

" visual autocomplete for command menu
set wildmenu

" redraw only when we need to.
set lazyredraw

" highlight matching [{()}]
set showmatch

" search
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" install coc stuff
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-pyright', 'coc-snippets']

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" jk is escape
inoremap jk <esc>

" save with ,w
map <leader>w :wa<CR>

" quit with ,q
map <leader>q :q<CR>

" copy cut paste
map <leader>c "+y
map <leader>x "+x
map <leader>y "+gP

" comment
map <leader>m :Commentary<CR>

" check wakatime with ,t
map <leader>t :WakaTimeToday<CR>

" toggle nerdtree
map <C-n> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" faster buffer switching
map gn :bn<cr>
map gp :bp<cr>
noremap <C-w> :bd<Cr>
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>c0 <Plug>lightline#bufferline#delete(10)

nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" more natural splitting
set splitbelow
set splitright

" moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" set statusline / tabline
set laststatus=2
set showtabline=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [
      \        [ 'mode', 'paste' ],
      \        [ 'git', 'readonly', 'filename', 'modified', 'status_branch' ], 
      \ ],
      \ 'right':[
      \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
      \     [ 'status_changes', 'blame' ],
      \   ],
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [] ],
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_function': {
      \   'blame': 'LightlineGitBlame',
      \   'status_branch': 'LightlineGitStatusBranch',
      \   'status_changes': 'LightlineGitStatusChanges',
      \ },
      \ }

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineGitStatusBranch() abort
  let status_branch = get(g:, 'coc_git_status', '')
  return winwidth(0) > 150 ? status_branch : ''
endfunction

function! LightlineGitStatusChanges() abort
  let status_changes = get(b:, 'coc_git_status', '')
  return winwidth(0) > 150 ? status_changes : ''
endfunction

let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#clickable = 1
let g:lightline.component_raw = {'buffers': 1}

" autosave on lose focus
:au FocusLost * :wa

" allow mouse
set mouse=a

" git
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)

" prettier
let g:prettier#exec_cmd_path = "~/.node_modules/bin/prettier"
autocmd BufWritePre *.js,*.html,*.css,*.scss,*.md execute ':PrettierAsync'

" goyo
nnoremap <Leader>g :Goyo<CR>

" autoformat python on save
" autocmd BufWritePre *.py execute ':CocCommand python.sortImports'
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
let g:autopep8_aggressive=1

" use vcs as root dir
let g:startify_change_to_vcs_root = 1

" snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:jedi#completions_enabled = 0

" terminal
let g:neoterm_default_mod = 'botright'
let g:neoterm_autoinsert = 1
nnoremap <C-t> :Ttoggle resize=15<CR>
