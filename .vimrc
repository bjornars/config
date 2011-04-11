"
" ~bjornar's vimrc
"   -- adapted from postlogic


"Functions 'n stuff
if v:progname =~? "evim"
  finish
endif

if v:version >= 700
  try
    setlocal numberwidth=3
  catch
  endtry
endif

if has('gui_running')
    set columns=90
    set lines=40
    set clipboard+=unnamed
    set guioptions+=a
    set guioptions+=c
    set guioptions-=T
"    set guioptions-=m
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
    "set guifont=Monospace
elseif (&term == 'screen.linux') || (&term =~ '^linux')
    set t_Co=8
elseif (&term == 'rxvt-unicode') || (&term =~ '^xterm') || (&term =~ '^screen')
    set ttymouse=xterm
endif

colorscheme xoria256 

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

" Folding
"if has("folding")
"    set foldenable
"    set foldmethod=indent
"    set foldlevel=1
"    set foldminlines=5
"endif

set wildchar=<tab>
set wildmenu
set wildmode=longest:full,full

if v:version >= 700
    set cursorline
    set completeopt=menu,menuone,longest,preview
    set numberwidth=1
    
    "popup coloring - use mine, not yours
    hi Pmenu ctermbg=2 guibg=darkolivegreen
    hi PmenuSel ctermbg=0 guibg=black
endif

" Plugins

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

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

set noswapfile
