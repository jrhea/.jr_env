set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set number              " show line numbers
set hlsearch            " highlight matches

" enable filetype detection
filetype on
filetype plugin on
filetype indent on " file type based indentation

" tab/space config
set expandtab
if has("autocmd")

    " If the filetype is Makefile then we need to use tabs
    " So do not expand tabs into space.
    autocmd FileType make   set noexpandtab

endif
