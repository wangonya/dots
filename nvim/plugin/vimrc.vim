set noswapfile
set autoread

nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent><leader>0 <Cmd>BufferLineGoToBuffer 10<CR>
nnoremap <silent><leader>bn <Cmd>bn<CR>
nnoremap <silent><leader>bp <Cmd>bp<CR>

" signify
highlight link SignifySignAdd             DiffAdd
highlight link SignifySignChange          DiffChange
highlight link SignifySignChangeDelete    SignifySignChange
highlight link SignifySignDelete          DiffDelete
highlight link SignifySignDeleteFirstLine SignifySignDelete
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight SignifySignAdd    ctermfg=29  guifg=#50fa7b cterm=NONE gui=NONE
highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE
let g:signify_sign_add               = '|'
let g:signify_sign_delete            = '|'
let g:signify_sign_change            = '|'
