" work-in-progress vimrc that's reasonable to use on servers

" keyboard remaps
nnoremap - dd
nnoremap H ^
nnoremap L $
nnoremap ,d :b#<bar>bd#<CR>
nnoremap <C-b> :make!<CR>

cnoremap <Esc><BS> <C-w>

inoremap jk <ESC>
inoremap <Esc><BS> <C-w>
inoremap <C-u> <Esc>gUiwie

let mapleader = ","
nnoremap <Leader>= gg=G<C-o><C-o>
nnoremap <Leader>ev :split $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>
nnoremap <Leader><space> :noh<cr>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" copy filepath
nnoremap <Leader>fp :!ls %:p \| tr -d '\n' \| pbcopy<cr><cr>

"" faster window keys
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

set confirm
set hidden
set autoread
set autowrite
set wrap
set linebreak
set history=1000
set spelllang=en_us
set formatoptions=tcro
set shortmess-=S

"""" shell settings
set shell=/bin/zsh

"""" remove trailing whitespace for all files
autocmd BufWritePre * :%s/\s\+$//e

"" unfamiliar file extensions"
" autocmd BufRead,BufNewFile *njk set filetype jinja.html

"""" tab settings
set expandtab shiftwidth=2 tabstop=2 softtabstop=2 smarttab

"""" syntax-specific settings
set textwidth=100
set colorcolumn=+1
autocmd FileType python,java setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType html,markdown,text setlocal spell
autocmd FileType scheme setlocal lisp
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
autocmd FileType html setlocal nowrap

set foldmethod=syntax "syntax highlighting items specify folds
set foldcolumn=1 "defines 1 col at window left, to indicate folding
set foldlevelstart=99 "start file with all folds opened

""activate folding by JS syntax
""let g:javaScript_fold=1
set lispwords+=for-each,#%module-begin,define-macro,define-macro-cases,module,


"""""" user interface settings
set ruler
set scrolloff=2
set sidescrolloff=5
set number relativenumber
set backspace=indent,eol,start
set lazyredraw

"" paste mode lets you paste without indents
set pastetoggle=<F3>

"""" search settings
set path+=**
set wildmenu
set wildignore+=**/build/**
set wildignore+=**/node_modules/**

"""" colors
syntax on
set re=0
set t_Co=256
set background=dark

"""" disable error bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""" commands
command PrintLink echo printf("%s /%s#L%d", trim(system('gh-link')), @%, line("."))
command CodeLink redir @* | PrintLink

"""" make programs
autocmd FileType python set makeprg=python3\ %
autocmd FileType scala set makeprg=scala\ %
autocmd FileType scheme set makeprg=racket\ %
autocmd FileType rust set makeprg=cargo\ test

"""" file browser settings
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S+'

"""" autocomplete
inoremap <Leader>c </<C-x><C-o>

"""" search settings
set incsearch
set hlsearch
set ignorecase
set smartcase

"""" plugin settings
"" install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

"""" install plugins
"" run :PlugInstall after adding a new one
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mattn/emmet-vim'
Plug 'lepture/vim-jinja'

autocmd BufNewFile,BufRead *.njk set ft=jinja
autocmd Filetype clojure,scheme let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"'}

" " initialize plugin system
call plug#end()
filetype plugin indent on

"""" Emmet settings
let g:user_emmet_leader_key='<C-T>'
let g:user_emmet_install_global = 0
autocmd FileType html,jinja EmmetInstall

"""" Theme settings
"" to match background, set terminal to RGB(48,48,48)
let g:dracula_italic = 0
color dracula

"""" FZF search commands
nnoremap <C-p> :GFiles --cached --others --exclude-standard<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>T :Tags<CR>

"" requires OS installation of ripgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
nnoremap <C-f> :Rg<CR>
" nnoremap <C-f> :grep<space>
imap <C-f> <ESC><C-f>

"" airline settings
set laststatus=2
" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled=1

