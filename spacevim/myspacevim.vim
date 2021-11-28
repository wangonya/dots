function! myspacevim#after() abort
    " copy cut paste
    map <leader>c "+y
    map <leader>x "+x
    map <leader>y "+gP
endfunction