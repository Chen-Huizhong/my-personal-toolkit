"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The customized VIM configuration by Huizhong Chen.
"
" Last updated: 2026-02-06
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ====================================================================
" 1. General Settings
" ====================================================================
set nocompatible                " Use Vim defaults (not Vi)
set clipboard^=unnamed,unnamedplus " Sync with system clipboard
set iskeyword+=_,$,@,%,#,-      " Symbols treated as part of a word
set shortmess=atl               " Avoid 'press enter' prompts
set whichwrap+=<,>,h,l          " Keys can move to next/prev line
set history=1000                " Command history limit
set confirm                     " Prompt to save changes
set mouse=a                     " Enable mouse in all modes
set nojoinspaces                " One space after punctuation
set nofoldenable                " Start with folds open
set hidden                      " Switch buffers without saving
let $LANG='en'                  " Interface language
set langmenu=en                 " Menu language

" ====================================================================
" 2. Display & UI Settings
" ====================================================================
set number                      " Show line numbers
set relativenumber              " Show relative line numbers for jumping
set noruler                     " Show cursor position
set cursorline                  " Highlight current line
set nocursorcolumn              " Disable column highlight (speed)
set textwidth=80                " Hard wrap at 80 chars
set wrap                        " Enable visual line wrapping
set linebreak                   " Don't wrap lines in the middle of a word
set wrapmargin=2                " Set margin for wrapping
set scrolloff=10                " Context lines around cursor
set laststatus=2                " Always show status line
set cmdheight=1                 " Command bar height
set showcmd                     " Show partial commands in the bottom bar
set showmode                    " Display the current mode (Normal, Insert, etc.)
set showmatch                   " Briefly jump to matching brackets/braces
set matchtime=2                 " Tenths of a second to show the matching bracket
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
set colorcolumn=81              " Vertical line at column 81
set splitright                  " Open new vertical splits to the right
set splitbelow                  " Open new horizontal splits below
set list                        " Show invisible characters (tabs, trailing spaces)
set listchars=tab:>-,nbsp:~,trail:∙,eol:¶
set lazyredraw
" Add a bit extra margin to the left
set foldcolumn=1

" ====================================================================
" 3. Search & Indentation
" ====================================================================
" Search
set incsearch                   " Find results as you type
set hlsearch                    " Highlight search results
set ignorecase                  " Case-insensitive searching
set smartcase                   " Case-sensitive if search contains uppercase

" Indentation
set autoindent                  " Copy indent from current line to next
set smartindent                 " Be smart about automatic indentation
set shiftwidth=4                " Use 4 spaces for (auto)indent
set tabstop=4                   " Use 4 spaces for a tab
set expandtab                   " Convert tabs to spaces
set smarttab                    " Insert blanks according to 'shiftwidth'
filetype plugin indent on

" ====================================================================
" 4. File Handling & Encoding
" ====================================================================
set encoding=utf-8              " Internal encoding
set fileencoding=utf-8          " File write encoding
set nobackup                    " Disable backup files
set noswapfile                  " Disable swap files (.swp)
set nowb                        " Disable 'writebackup'
set noundofile                  " Disable persistent undo
set autochdir                   " Automatically change directory to current file
set autoread                    " Auto-reload file if changed outside Vim
set autowrite                   " Auto-save before commands like :next and :make

" Bell settings (Silence the beast)
set noerrorbells
set novisualbell
set t_vb=                       " Clear the visual bell terminal string
set tm=500
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
" Add specified suffix here.
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee
        \ :call CleanExtraSpaces()
endif

" ====================================================================
" 5. Command Line & Tabline
" ====================================================================
set wildmenu                    " Visual command completion
set wildmode=longest:list,full  " Completion behavior
set showtabline=2               " Always show tab bar

" ====================================================================
" 6. Key Mappings & Leader
" ====================================================================
nnoremap <space> <nop>
let mapleader = " "
let g:mapleader = " "

" Disable Ex-mode (prevents accidental Q presses)
nmap Q <Nop>

" Buffer Navigation
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>h :bprevious<CR>
" `<leader> + d` to close current buffer
" keep window alive and close the buffer
nnoremap <Leader>d :bdelete<CR>
" Switch to the last-operated buffer
nnoremap <Leader>k :b#<CR>
" List all of the buffers
nnoremap <Leader>j :ls<CR>:echom "Buffer Number: "<CR>:b

" Disable Arrow Keys (Force h,j,k,l habit)
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Window Navigation (Ctrl + h,j,k,l)
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Fast Exit Insert Mode
inoremap jj <Esc>

" Search Mappings (Center results)
nnoremap <silent> n n:normal! zz<CR>
nnoremap <silent> N N:normal! zz<CR>
nnoremap <silent> * *:normal! zz<CR>
nnoremap <silent> # #:normal! zz<CR>
nnoremap <silent> g* g*:normal! zz<CR>
" Alternatives to # and *
nnoremap <Leader>, #:normal! zz<CR>
nnoremap <Leader>. *:normal! zz<CR>
" Quick nohightligh
nnoremap <silent> <Leader>n :nohlsearch<CR>

" Custom Movement
noremap H ^
noremap L $

" Wrap-aware movements (gj/gk instead of j/k for visual lines)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Visual Mode: Keep selection after shifting indent
vnoremap < <gv
vnoremap > >gv

" Lazy shortcuts
nnoremap ; :
nmap <Leader>q :wq<CR>

" ====================================================================
" 7. Plugin Management (vim-plug) (conditional)
" ====================================================================
" Instruction:
"     Vim-Plug Installation:
"     1. Download `plug.vim` on 
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"     2. Put it on the path `~/.vim/autoload/plug.vim`.
"
"     Add your favourite plugs between `call plug#bigin('~/.vim/plugged')` and
"       `call plug#end()`.
" ====================================================================
" Note: To install plugs, execute command `:PlugInstall`.
" Note: To uninstall plugs, execute command `:PlugClean`.
" ====================================================================
let s:plug_path = expand('~/.vim/autoload/plug.vim')
if filereadable(s:plug_path)
    call plug#begin('~/.vim/plugged')

        Plug 'easymotion/vim-easymotion'             " Fast navigation
        Plug 'tpope/vim-surround'                    " Edit surroundings (quotes, brackets)
        Plug 'tpope/vim-commentary'                  " Commentary
        Plug 'preservim/nerdtree'                    " File explorer
        Plug 'mhinz/vim-signify', { 'tag': 'legacy' } " Show git diff in gutter
        Plug 'Xuyuanp/nerdtree-git-plugin'           " Git status for NERDTree
        Plug 'ryanoasis/vim-devicons'                " File icons
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Icon colors
        Plug 'itchyny/lightline.vim'                 " Light status bar
        Plug 'mengelbrecht/lightline-bufferline'     " Light buffer line
        Plug 'jiangmiao/auto-pairs'                  " Auto-close brackets
        Plug 'vim/colorschemes'                      " Collection of colors
        Plug 'mg979/vim-visual-multi', {'branch': 'master'}  " Mult-cursor

    call plug#end()

    " NERDTree
    nnoremap <C-t> :NERDTreeToggle<CR>
    " Auto-open NERDTree if Vim starts with a directory
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
        \ !exists('s:std_in') | \ execute 'NERDTree' argv()[0] | wincmd p | enew |
        \ execute 'cd '.argv()[0] | endif
    " Auto-close Vim if NERDTree is the last window
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
        \ exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " EasyMotion
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_do_mapping = 0
    nmap <Leader>s <Plug>(easymotion-s)
    nmap <leader><leader>s <Plug>(easymotion-s2)
    nmap <leader>w <Plug>(easymotion-w)
    nmap <leader>b <Plug>(easymotion-b)

    " Lightline & Bufferline
    let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'tabline': {
        \    'left': [ ['buffers'] ],
        \    'right': [ ['close'] ],
        \ },
        \ 'component_expand': {
        \   'buffers': 'lightline#bufferline#buffers'
        \ },
        \ 'component_type': {
        \   'buffers': 'tabsel'
        \ },
        \ }
    let g:lightline#bufferline#show_number=3
    let g:lightline#bufferline#ordinal_number_map = {
        \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
        \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}
    let g:lightline#bufferline#unnamed = '[No Name]'
    nmap <Leader>1 <Plug>lightline#bufferline#go(1)
    nmap <Leader>2 <Plug>lightline#bufferline#go(2)
    nmap <Leader>3 <Plug>lightline#bufferline#go(3)
    nmap <Leader>4 <Plug>lightline#bufferline#go(4)
    nmap <Leader>5 <Plug>lightline#bufferline#go(5)
    nmap <Leader>6 <Plug>lightline#bufferline#go(6)
    nmap <Leader>7 <Plug>lightline#bufferline#go(7)
    nmap <Leader>8 <Plug>lightline#bufferline#go(8)
    nmap <Leader>9 <Plug>lightline#bufferline#go(9)
    nmap <Leader>0 <Plug>lightline#bufferline#go(10)
    nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
    nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
    nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
    nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
    nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
    nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
    nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
    nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
    nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)
    nmap <Leader>c0 <Plug>lightline#bufferline#delete(10)

endif

" ====================================================================
" 9. Finishing Touches
" ====================================================================
" Color Scheme
syntax enable
set background=dark
try
    colorscheme wildcharm
catch
endtry

" Remember cursor position when reopening a file
if has("autocmd")
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif

" Fix potential background color issues in some terminals
if &term =~ '256color'
    set t_ut=
endif
