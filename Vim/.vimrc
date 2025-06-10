"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The customized VIM configuration by Huizhong Chen.
" This file is used to set up various Vim options and key mappings.
"
" Last updated: 2025-06-10
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General settings
set nocompatible              " Disable compatibility mode
set confirm                   " Confirm when closing unsaved/readonly files
set iskeyword+=_,$,@,%,#,-    " Treat these symbols as part of words
set shortmess=atl             " Shorten messages
set mouse=                    " Mouse support (uncomment to enable)
set selection=                " Selection mode (uncomment to enable)

" Display settings
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set ruler                     " Show ruler
set cursorline                " Highlight current line
set textwidth=80              " Set text width
set wrap                      " Enable line wrapping
set linebreak                 " Break lines at convenient points
set wrapmargin=2              " Margin for wrapping
set scrolloff=5               " Lines of context when scrolling
"set sidescrolloff=15         " Horizontal scroll offset (uncomment to enable)
set laststatus=2              " Always show status line
set cmdheight=1               " Command line height
set showcmd                   " Show command in bottom bar
set showmatch                 " Highlight matching brackets

" Search settings
set incsearch                 " Incremental search
set hlsearch                  " Highlight search results
set smartcase                 " Smart case search

" Indentation settings
set autoindent                " Auto indent
set shiftwidth=4              " Indent width
set tabstop=4                 " Tab width
set expandtab                 " Use spaces instead of tabs
set smarttab                  " Smart tab

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" File handling
set nobackup                  " Don't create backup files
set noswapfile                " Don't create swap files
set nowb                      " Don't write backup files
set undofile                  " Don't keep undo history
"set backupdir=~/.vim/.backup//   " Backup directory (uncomment to enable)
"set directory=~/.vim/.swp//      " Swap file directory (uncomment to enable)
"set undodir=~/.vim/.undo//       " Undo file directory (uncomment to enable)

set autochdir                 " Auto change working directory
set noerrorbells              " No error bells
set novisualbell              " No visual bell

" History and completion
set history=1000              " Command history size
set autoread                  " Auto read files changed outside
set wildmenu                  " Enhanced command-line completion
set wildmode=longest:list,full

" List characters
set listchars=tab:»■,trail:■  " Show tabs and trailing spaces
set list

" Filetype and syntax
filetype indent on            " Enable filetype-based indentation
syntax enable                 " Enable syntax highlighting
"set background=dark          " Set background color (uncomment to enable)

" Spell checking
"set spell spelllang=en_us    " Enable spell checking

" Key mappings
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
map <space> l
