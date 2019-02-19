if !exists('g:os')
    if has('win32') || has ('win16')
        let g:os = 'Win'
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

"{{{ Vundle
filetype off
let iCanHazVundle=1
if g:os == 'Win'
    "{{{ Vundle install win
    let vundle_readme=expand('$HOME/vimfiles/bundle/Vundle.vim/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p $HOME/vimfiles/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim $HOME/vimfiles/bundle/Vundle.vim
        let iCanHazVundle=0
    endif
    "}}}
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$HOME/vimfiles/bundle/')
else
    "{{{ Vundle install ux
    let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
        let iCanHazVundle=0
    endif
    "}}}
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

Plugin 'VundleVim/Vundle.vim'
" Add plugins here:
Plugin 'fugitive.vim'

if iCanHazVundle == 0
    echo "Installing Vundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
call vundle#end()
filetype plugin indent on
"}}}

"{{{Misc Settings

" Necesary  for lots of cool vim things
set nocompatible
"
"Automatically cd into the directory that the file is in:"
set autochdir

"Highlight the current line
if g:os == 'Win'
    set nocul
else
    set cul
endif

"copy/paste winlike
source $VIMRUNTIME/mswin.vim
behave mswin

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set softtabstop=4

" Real men use gcc
"compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
"inoremap jj <Esc>

" Incremental searching is sexy
set incsearch

"i dont care about case when searching
set ignorecase

" Highlight things that we find with the search
set hlsearch
" Remove highlight on enter
nnoremap <silent> <CR> :noh<CR><CR>
"
"clear search pattern on startup
let @/ = ""

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4

if has("multi_byte")
if &termencoding == ""
let &termencoding = &encoding
endif
set encoding=utf-8
setglobal fileencoding=utf-8
"setglobal bomb
set fileencodings=ucs-bom,utf-8,latin1
endif
set encoding=utf-8

set splitbelow
set splitright
set winheight=30
set winminheight=5


" }}}

"{{{ Functions
"{{{ Open URL in browser

function! Browser ()
let line = getline (".")
let line = matchstr (line, "http[^   )]*")
exec "!explorer.exe ".line
endfunction

"}}}

"{{{ Todo List Mode

function! TodoListMode()
e ~/.todo.otl
wincmd l
set foldlevel=1
tabnew ~/.notes.txt
tabfirst
" or 'norm! zMzr'
endfunction

"}}}

"}}}

"{{{ Mappings

"{{{ Vanilla
"change leader to ,
:let mapleader = ","

" save and closes a file with a leader
nnoremap <silent> <Leader>x :wq<CR>
nnoremap <silent> <Leader>w :w<CR>

" Open Url on this line with the browser \w
map <Leader>f :call Browser ()<CR>

" Next Tab
"nnoremap <silent> <C-h> :tabnext<CR>
" Previous Tab
"nnoremap <silent> <C-l> :tabprevious<CR>
" New Tab
"nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-J> <C-W><C-J>
nnoremap <silent> <C-K> <C-W><C-K>
nnoremap <silent> <C-L> <C-W><C-L>
nnoremap <silent> <C-H> <C-W><C-H>
nnoremap <silent> <C-,> :vertical resize -5<CR>
nnoremap <silent> <C-.> :vertical resize +5<CR>
nnoremap <silent> - :resize -5<CR>
nnoremap <silent> + :resize +5<CR>

" Edit .vimrc
"nnoremap <silent> <Leader>ev :tabnew<CR>:e $MYVIMRC<CR>
nnoremap <silent> <Leader>ev :vsp ~/.vimrc<CR>

"reload .vimrc
nnoremap <silent> <Leader>sv :source $MYVIMRC<cr>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
"inoremap <silent> <Up> <Esc>gka
"inoremap <silent> <Down> <Esc>gja

"nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

" Swap ; and :  Convenient.
nnoremap ; :

"autoindent paster code
:nnoremap p p=`]

"reindent whole file
nnoremap <Leader>= gg=G''

"save file and open current directory
nnoremap <Leader>. :w<CR>:e .<CR>

"compile rust
nnoremap <Leader>c :w<CR>:!cargo check<CR>
nnoremap <Leader>r :w<CR>:!cargo run<CR>


"}}}

"}}}

set noswapfile
set guifont=Lucida_Console:h11
set fileformats=dos,unix

set scrolloff=10 "allways view at least 5 lines up/down from the cursor
set previewheight=5

set background=dark

"set backup
"set backupdir=~\vimfiles\backup
"set directory=~\vimfiles\tmp
set autoread "watch for file changes

colorscheme darkblue
