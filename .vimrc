if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax on

set number

set cursorline
highlight clear CursorLineNR 
highlight clear CursorLine
highlight CursorLineNR ctermfg=red

set autoindent
set tabstop=4

set hlsearch
set incsearch

set noswapfile

set laststatus=2

" Vim Plugins
call plug#begin('~/.vim/plugged')
cal plug#end()
