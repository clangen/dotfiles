" General
set nobackup
set writebackup
set clipboard=unnamed
set backspace=indent,eol,start
set incsearch
set matchtime=7
set matchpairs=(:),[:],{:},<:>
set noerrorbells
set novisualbell
set number
set report=0
set showmatch
set modeline
set smartcase
set ttyfast
set nohlsearch
" set mouse=a
set list
set listchars=tab:→·,trail:·,nbsp:¬

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r,latin1
set termencoding=utf-8

" Status line
set laststatus=2
set showcmd
set showmode
set ruler
set statusline=[%n]\ %F\ \ Format=%{&ff}\ Type=%Y\ \ %r\ %1*%m%*%w%=%(Line:\ %l%)\ Column:\ %5(%c%V/%{strlen(getline(line('.')))}%)\ %4(%)%p%%

" Spelling
set nospell
set spellsuggest=double
set spelllang=en_us

" Syntax highlighting
syntax enable
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set linebreak
set colorcolumn=120

" History
set history=500
set undolevels=500
set viminfo='100,<500,:10000,@10000,/10000,s1024,f1,h,r/tmp,n~/.history/viminfo
