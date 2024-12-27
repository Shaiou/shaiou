set nu
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set hlsearch
set shell=/bin/bash
set clipboard=unnamedplus
syntax on
filetype plugin on
au BufNewFile,BufRead *.hcl* set filetype=tf
au BufNewFile,BufRead *.tf* set filetype=hcl
au BufNewFile,BufRead *.y*ml* set filetype=yaml
autocmd FileType json setlocal expandtab sw=2 ts=2 sts=2 sw=2
autocmd FileType hcl setlocal expandtab sw=2 ts=2 sts=2 sw=2
autocmd FileType tf setlocal expandtab sw=2 ts=2 sts=2 sw=2
autocmd FileType yaml setlocal expandtab sw=2 ts=2 sts=2 sw=2
autocmd BufWritePre * :%s/\s\+$//e

call plug#begin()

Plug 'girishji/vimcomplete'

call plug#end()
