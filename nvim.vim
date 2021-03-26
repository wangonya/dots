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
Plug 'psf/black', { 'branch': 'stable' }
Plug 'junegunn/goyo.vim'
call plug#end()

colorscheme dracula

" install coc stuff
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-pyright']

" don't need vi
set nocompatible

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

" check wakatime with ,t
map <leader>t :WakaTimeToday<CR>

" toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" faster buffer switching
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
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
      \        [ 'git', 'readonly', 'filename', 'modified', 'status_branch' ] 
      \ ],
      \ 'right':[
      \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
      \     [ 'status_changes', 'blame' ]
      \   ],
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [] ]
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

" autoclose brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" autoformat python on save
autocmd BufWritePre *.py execute ':Black'

" goyo
nnoremap <Leader>g :Goyo<CR>
