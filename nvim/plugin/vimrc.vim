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

" netrw
let g:netrw_fastbrowse = 0 " close after oprning file"
let g:netrw_keepdir = 0 " keep the current directory and the browsing directory synced
let g:netrw_winsize = 15 " size of the Netrw window when it creates a split
let g:netrw_banner = 0 " hide banner
let g:netrw_liststyle = 3
nnoremap <Leader>e :Lexplore<CR>
