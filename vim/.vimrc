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
set cursorcolumn                    " Highlight current column
highlight CursorLine   ctermbg=237 guibg=#3a3a3a cterm=NONE gui=NONE
highlight CursorColumn ctermbg=237 guibg=#3a3a3a cterm=NONE gui=NONE
set textwidth=81                    " Set text width
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

" Settings of leader key
nnoremap <space> <nop>
let mapleader = " "

nnoremap <Leader>n :nohlsearch<CR>
nnoremap <Leader>, :bprevious<CR>
nnoremap <Leader>. :bnext<CR>


" Customized Statusline
function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

" Costumized Colors
hi User1 guifg=#ffdad8 guibg=#880c0e ctermfg=224 ctermbg=88
hi User2 guifg=#000000 guibg=#F4905C ctermfg=16  ctermbg=173
hi User3 guifg=#292b00 guibg=#f4f597 ctermfg=58  ctermbg=229
hi User4 guifg=#112605 guibg=#aefe7B ctermfg=22  ctermbg=155
hi User5 guifg=#051d00 guibg=#7dcc7d ctermfg=22  ctermbg=114
hi User7 guifg=#ffffff guibg=#880c0e ctermfg=231 ctermbg=88  cterm=bold gui=bold
hi User8 guifg=#ffffff guibg=#5b7fbb ctermfg=231 ctermbg=67
hi User9 guifg=#ffffff guibg=#810085 ctermfg=231 ctermbg=90
hi User0 guifg=#ffffff guibg=#094afe ctermfg=231 ctermbg=27
hi User6 guifg=#ffffff guibg=#005f00 ctermfg=231 ctermbg=22   " NORMAL
hi User10 guifg=#000000 guibg=#afff00 ctermfg=16  ctermbg=154 " INSERT
hi User11 guifg=#ffffff guibg=#5f00af ctermfg=231 ctermbg=55  " VISUAL
hi User12 guifg=#ffffff guibg=#870000 ctermfg=231 ctermbg=88  " REPLACE

" Costumized Statusline
function! StatuslineMode()
  let l:m = mode()
  if l:m ==# 'n'
    return '%#User6# NORMAL '
  elseif l:m ==# 'i'
    return '%#User10# INSERT '
  elseif l:m ==# 'R'
    return '%#User12# REPLACE '
  elseif l:m ==# 'c'
    return '%#User6# COMMAND '
  elseif l:m ==# 'v' || l:m ==# 'V' || l:m ==# "\<C-v>"
    return '%#User11# VISUAL '
  else
    return '%#User6# '.l:m.' '
  endif
endfunction

function! StatusEnc()
  return &fenc != '' ? &fenc : &enc
endfunction

function! StatusBom()
  return &bomb ? ',BOM' : ''
endfunction

function! StatusSpell()
  return &spelllang . HighlightSearch()
endfunction

function! MyStatusline()
  return StatuslineMode()
        \ . '[%n]'
        \ . ' %<%F%m%r%w  %='
        \ . '%8* R:%l/%L'
        \ . '%8* C:%02c '
        \ . '%0* %P %y '
"        \ . '%2*%y'
"        \ . '%8* R:%l/%L (%02p%%) '
"        \ . '%5*' . StatusSpell()
"        \ . '%3*' . StatusEnc()
"        \ . '%3*' . StatusBom()
"        \ . '%4*' . &ff
endfunction

set statusline=%!MyStatusline()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The configurations of plugins start here.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The installation of vim-plut:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')           " Where the plugins install

    Plug 'easymotion/vim-easymotion'            " EasyMotion
    Plug 'tpope/vim-surround'                   " Vim-Surround
"    Plug 'neoclide/coc.nvim', {'branch': 'release'}
"    Plug 'vim-airline/vim-airline'
"    Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Configuration for vim-airline
"let g:airline_theme='simple'

" Configuration for EasyMotion
" installation: 
" git clone https://github.com/easymotion/vim-easymotion.git ~/.vim/pack/plugins/start/vim-easymotion
let g:EasyMotion = "asdfghjklqwertyuiopzxcvbnm"
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" <Leader>s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" Move to line
map  <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-w)
map  <Leader>W <Plug>(easymotion-b)
" Move hjkl
map  <Leader>l <Plug>(easymotion-lineforward)
map  <Leader>j <Plug>(easymotion-j)
map  <Leader>k <Plug>(easymotion-k)
map  <Leader>h <Plug>(easymotion-linebackward)

" TODO:
" Reference key map of vscode-vim extension:
" Once easymotion is active, initiate motions using the following commands.
" After you initiate the motion, text decorators/markers will be displayed
" and you can press the keys displayed to jump to that position.
" `leader` is configurable and is `\` by default.
"
"| Motion Command                      | Description                                        |
"| ----------------------------------- | -------------------------------------------------- |
"| `<leader><leader> s <char>`         | Search character                                   |
"| `<leader><leader> f <char>`         | Find character forwards                            |
"| `<leader><leader> F <char>`         | Find character backwards                           |
"| `<leader><leader> t <char>`         | Til character forwards                             |
"| `<leader><leader> T <char>`         | Til character backwards                            |
"| `<leader><leader> w`                | Start of word forwards                             |
"| `<leader><leader> b`                | Start of word backwards                            |
"| `<leader><leader> l`                | Matches beginning & ending of word, camelCase,
"                                        after `_`, and after `#` forwards |
"| `<leader><leader> h`                | Matches beginning & ending of word, camelCase,
"                                        after `_`, and after `#` backwards |
"| `<leader><leader> e`                | End of word forwards                               |
"| `<leader><leader> ge`               | End of word backwards                              |
"| `<leader><leader> j`                | Start of line forwards                             |
"| `<leader><leader> k`                | Start of line backwards                            |
"| `<leader><leader> / <char>... <CR>` | Search n-character                                 |
"| `<leader><leader><leader> bdt`      | Til character                                      |
"| `<leader><leader><leader> bdw`      | Start of word                                      |
"| `<leader><leader><leader> bde`      | End of word                                        |
"| `<leader><leader><leader> bdjk`     | Start of line                                      |
"| `<leader><leader><leader> j`        | JumpToAnywhere motion; default behavior matches
"                                        beginning & ending of word, camelCase, after `_` and after `#` |
"
"`<leader><leader> (2s|2f|2F|2t|2T) <char><char>` and `<leader><leader><leader> bd2t <char>char>` 
" are also available.
"The difference is character count required for search.
"For example, `<leader><leader> 2s <char><char>` requires two characters, and search by two characters.
"For example, `<leader><leader> 3s <char><char>` requires three characters, and search by three characters.
"This mapping is not a standard mapping, so it is recommended to use your custom mapping.

" Configuration for Vim-Surround
" installation:
" git clone https://tpope.io/vim/surround.git ~/.vim/pack/tpope/start/surround
" vim -u NONE -c "helptags surround/doc" -c q
