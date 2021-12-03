if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" fzf

" Color scheme
Plug 'ayu-theme/ayu-vim'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Rust
Plug 'neoclide/coc.nvim'
Plug 'rust-lang/rust.vim'
call plug#end()

set termguicolors
let ayucolor="mirage"
colorscheme ayu

set rnu
set nu
set splitright

" Autocmd
autocmd BufWritePost *Xresources !xrdb %
autocmd BufWritePost *init.vim source ~/.config/nvim/init.vim

" Terminal
tnoremap <Esc> <C-\><C-n>
