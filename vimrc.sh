set nocompatible
filetype off

" writes the content of the file automatically if you call :make
set autowrite

" make vim store swapfiles at the home directory
" or it will store the files inside the project
" folders and you can mistakenly send those files
" together with your git commits
set directory=$home/.vim/swapfiles/

" dont use octave numbers when formatting numbers
set nrformats=

" good formatting
set gfn=Monaco:h16
set linespace=2

" ---------------------------------------------------------------------------

set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Let Vundle manage Vundle
Plugin 'gmarik/vundle'

" My Bundles
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes.git'

" needed by vim-colorscheme-switcher
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-colorscheme-switcher.git'

" remove esc key and bind esc to 'jk' sequence
:inoremap jk <esc>

" relative line numbers
set number
set relativenumber

" use virtual numbers
" (https://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Make Ctrl-e jump to the end of the current line in the insert mode. This is
" handy when you are in the middle of a line and would like to go to its end
" without switching to the normal mode.
inoremap <C-e> <C-o>$
inoremap <C-b> <C-o>0

" automatically sets the current directory to the one containing the current file. Put it in your vimrc, enjoy life.
set autochdir

" Replace tabs with four spaces.
" Make sure that there is a tab character between the first pair of slashes when you copy this mapping into your .vimrc!
nnoremap <Leader>rts :%s/ /  /g<CR>


" ---------------------------------------------------------------------------


filetype plugin indent on

set cursorline
set expandtab
set modelines=0
set shiftwidth=2
set clipboard=unnamed
set synmaxcol=128
set ttyscroll=10
set encoding=utf-8
set tabstop=2
set nowrap
set number
set expandtab
set nowritebackup
set noswapfile
set nobackup
set hlsearch
set ignorecase
set smartcase

" Automatic formatting
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufWritePre *.go :%s/\s\+$//e
autocmd BufWritePre *.haml :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.scss :%s/\s\+$//e
autocmd BufWritePre *.slim :%s/\s\+$//e

au BufNewFile * set noeol
au BufRead,BufNewFile *.go set filetype=go

" No show command
autocmd VimEnter * set nosc

" Quick ESC
imap jj <ESC>

" Jump to the next row on long lines
map <Down> gj
map <Up>   gk
nnoremap j gj
nnoremap k gk

" format the entire file
map <leader>fef ggVG=

" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>

" Tab between buffers
noremap <tab> <c-w><c-w>

" Switch between last two buffers
noremap <leader><leader> <C-^>

" Move between buffers with vim nav keys
map <C-j> :bnext<cr>
map <C-k> :bprev<cr>
map <C-l> :tabn<cr>
map <C-h> :tabp<cr>

set wrap
