"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The customized VIM configuration by Huizhong Chen.
" This file is used to set up various Vim options and key mappings.
"
" Last updated: 2025-12-25
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" General settings
set nocompatible                    " Disable compatibility mode
set confirm                         " Confirm when closing unsaved/readonly files
set iskeyword+=_,$,@,%,#,-          " Treat these symbols as part of words
set shortmess=atl                   " Shorten messages
set mouse+=a                        " Mouse support (uncomment to enable)
"set selection=exclusive            " Selection mode (uncomment to enable)
set nojoinspaces                    " Suppress inserting two spaces between sentences
set backspace=indent,eol,start      " Backspace over anything
set whichwrap+=<,>,h,l
set nofoldenable                    " Disable folding by default
let $LANG='en'                      " Set language
set langmenu=en                     " Set menu language

" Display settings
set viewoptions=cursor
set number                          " Show line numbers
set relativenumber                  " Show relative line numbers
set ruler                           " Show ruler
set cursorline                      " Highlight current line
set nocursorcolumn                    " Highlight current column
highlight CursorLine   ctermbg=237 guibg=#3a3a3a cterm=NONE gui=NONE
highlight CursorColumn ctermbg=237 guibg=#3a3a3a cterm=NONE gui=NONE
set textwidth=80                    " Set text width
set wrap                            " Enable line wrapping
set linebreak                       " Break lines at convenient points
set wrapmargin=2                    " Margin for wrapping
set scrolloff=10                    " Lines of context when scrolling
"set sidescrolloff=15               " Horizontal scroll offset (uncomment to enable)
set laststatus=2                    " Always show status line
set cmdheight=1                     " Command line height
set showcmd                         " Show command in bottom bar
set showmode                        " Show mode status in bottom bar
set showmatch                       " Highlight matching brackets
set matchtime=2
set t_Co=256                        " 256 Colors
set colorcolumn=81                  " highlight specific columns
highlight ColorColumn ctermbg=lightcyan guibg=blue
" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
"set title


" Search settings
set incsearch                       " Incremental search
set hlsearch                        " Highlight search results
set ignorecase                      " ignore case while searching
set smartcase                       " Smart case search

" Indentation settings
set autoindent                      " Auto indent
set shiftwidth=4                    " Indent width
set tabstop=4                       " Tab width
set expandtab                       " Use spaces instead of tabs
set smarttab                        " Smart tab

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" File handling
set nobackup                        " Don't create backup files
set noswapfile                      " Don't create swap files
set nowb                            " Don't write backup files
set noundofile                      " Don't keep undo history
set backupdir=~/.vim/.backup//      " Backup directory (uncomment to enable)
set directory=~/.vim/.swp//         " Swap file directory (uncomment to enable)
set undodir=~/.vim/.undo//          " Undo file directory (uncomment to enable)

set autochdir                       " Auto change working directory
set noerrorbells                    " No error bells
set novisualbell                    " No visual bell
set noerrorbells visualbell t_vb=   " Disable audible bell

" History and completion
set history=1000                    " Command history size
set autoread                        " Auto read files changed outside
set autowrite
set hidden
set wildmenu                        " Enhanced command-line completion
set wildmode=longest:list,full

" List characters
set listchars=tab:>-,nbsp:~,trail:∙ " set list to see tabs and non-breakable spaces
set listchars+=eol:¶
set list

" Filetype and syntax
filetype indent on                  " Enable filetype-based indentation
syntax on
syntax enable                       " Enable syntax highlighting
"set background=dark                " Set background color (uncomment to enable)

" Spell checking
"set spell spelllang=en_us          " Enable spell checking


" Key mappings
"
" Here are some basic rules for key mappings:
" i for insert mode
" n for normal mode
" v for visual mode
" c for command mode
"
" `noremap` for nonrecursive mapping
" `unmap` for delete mapping of one key
"
" `mapclear` clears all the key mappings.

nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
" for moving among windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" lazy man
inoremap jj <ESC>l

" Settings of leader key
nnoremap <space> <nop>
let mapleader = " "

nnoremap <Leader>n :nohlsearch<CR>
nnoremap <Leader>, :bprevious<CR>
nnoremap <Leader>. :bnext<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customized Statusline (deprecated after vim-airline)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! HighlightSearch()
"   if &hls
"     return 'H'
"   else
"     return ''
"   endif
" endfunction
" 
" " Costumized Colors
" hi User1 guifg=#ffdad8 guibg=#880c0e ctermfg=224 ctermbg=88
" hi User2 guifg=#000000 guibg=#F4905C ctermfg=16  ctermbg=173
" hi User3 guifg=#292b00 guibg=#f4f597 ctermfg=58  ctermbg=229
" hi User4 guifg=#112605 guibg=#aefe7B ctermfg=22  ctermbg=155
" hi User5 guifg=#051d00 guibg=#7dcc7d ctermfg=22  ctermbg=114
" hi User7 guifg=#ffffff guibg=#880c0e ctermfg=231 ctermbg=88  cterm=bold gui=bold
" hi User8 guifg=#ffffff guibg=#5b7fbb ctermfg=231 ctermbg=67
" hi User9 guifg=#ffffff guibg=#810085 ctermfg=231 ctermbg=90
" hi User0 guifg=#ffffff guibg=#094afe ctermfg=231 ctermbg=27
" hi User6 guifg=#ffffff guibg=#005f00 ctermfg=231 ctermbg=22   " NORMAL
" hi User10 guifg=#000000 guibg=#afff00 ctermfg=16  ctermbg=154 " INSERT
" hi User11 guifg=#ffffff guibg=#5f00af ctermfg=231 ctermbg=55  " VISUAL
" hi User12 guifg=#ffffff guibg=#870000 ctermfg=231 ctermbg=88  " REPLACE
" 
" " Costumized Statusline
" function! StatuslineMode()
"   let l:m = mode()
"   if l:m ==# 'n'
"     return '%#User6# NORMAL '
"   elseif l:m ==# 'i'
"     return '%#User10# INSERT '
"   elseif l:m ==# 'R'
"     return '%#User12# REPLACE '
"   elseif l:m ==# 'c'
"     return '%#User6# COMMAND '
"   elseif l:m ==# 'v' || l:m ==# 'V' || l:m ==# "\<C-v>"
"     return '%#User11# VISUAL '
"   else
"     return '%#User6# '.l:m.' '
"   endif
" endfunction
" 
" function! StatusEnc()
"   return &fenc != '' ? &fenc : &enc
" endfunction
" 
" function! StatusBom()
"   return &bomb ? ',BOM' : ''
" endfunction
" 
" function! StatusSpell()
"   return &spelllang . HighlightSearch()
" endfunction
" 
" function! MyStatusline()
"   return StatuslineMode()
"         \ . '[%n]'
"         \ . ' %<%F%m%r%w  %='
"         \ . '%8* R:%l/%L'
"         \ . '%8* C:%02c '
"         \ . '%0* %P %y '
" "        \ . '%2*%y'
" "        \ . '%8* R:%l/%L (%02p%%) '
" "        \ . '%5*' . StatusSpell()
" "        \ . '%3*' . StatusEnc()
" "        \ . '%3*' . StatusBom()
" "        \ . '%4*' . &ff
" endfunction
" 
" set statusline=%!MyStatusline()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The configurations of plugins start here.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The installation of vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 
" NOTE: Don't forget to run `:PlugInstall` after you add a plugin.
" NOTE: And don't forget to run `:PlugClean` after delete one.

call plug#begin('~/.vim/plugged')           " Where the plugins install

    Plug 'easymotion/vim-easymotion'                    " EasyMotion
    Plug 'tpope/vim-surround'                           " Vim-Surround
    Plug 'mhinz/vim-signify', { 'tag': 'legacy' }       " vim-signify
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'                  " Git status flag
    Plug 'ryanoasis/vim-devicons'                       " File icon
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " File icon color
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'jiangmiao/auto-pairs'

call plug#end()

" Configuration for NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Start NERDTree when Vim starts with a directory argument
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Configuration for EasyMotion
let g:EasyMotion_keys = "asdfghjklqwertyuiopzxcvbnm"
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
" EasyMotion key mappings
" Move hjkl
map  <Leader>l <Plug>(easymotion-lineforward)
map  <Leader>j <Plug>(easymotion-j)
map  <Leader>k <Plug>(easymotion-k)
map  <Leader>h <Plug>(easymotion-linebackward)
" 1-character search 
nmap <Leader>s <Plug>(easymotion-s)
" 2-character search 
nmap <leader><leader>s <Plug>(easymotion-s2)
" Word motions
nmap <leader>w <Plug>(easymotion-w)
nmap <leader>b <Plug>(easymotion-b)
" Inline character motions
nmap <leader>f <Plug>(easymotion-fl)
nmap <leader>F <Plug>(easymotion-Fl)

" Configuration for vim-airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1          " Enable tab line
let g:airline_theme='dark'                         " Use this theme

" Configuration for vim's colorscheme
colorscheme wildcharm
