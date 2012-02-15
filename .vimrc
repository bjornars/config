"
" ~bjornar's vimrc
"   -- adapted from postlogic

set ttymouse=xterm
try
    set t_Co=256
    colorscheme xoria256
catch
    set t_Co=8
    colorscheme darkblue
endtry

" Options
set nocompatible
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch
set nowrap
set cmdheight=1
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set number
set laststatus=2
let html_use_css=1

set showmatch		" Show matching brackets.
set smartcase		" Do smart case matching
set autowrite		" Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned

" Enable mouse usage (all modes) in terminals, but allow right-click to be paste in putty
set mouse=nv

" Open tag in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

nmap zT vatzf

" Folding
" if has("folding")
"     set foldenable
"     set foldmethod=indent
"     set foldlevel=1
"     set foldminlines=50
" endif

set wildchar=<tab>
set wildmenu
set wildmode=longest:full,full
set cursorline
set completeopt=menu,menuone,longest,preview

syntax on
set hlsearch

if has("autocmd")
  filetype plugin indent on

  augroup vimrcEx
  au!

  autocmd FileType text setlocal textwidth=78

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
  set smartindent
endif

set aw

if $TERM=='screen'
    exe "set title titlestring=vim:%f"
    exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
    exe "set titleold=bash"
endif

highlight trailspace guibg=red ctermbg=red
match trailspace /\s\+\%#\@<!$\| /
set noswapfile
set tabpagemax=75
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

call pathogen#infect()
