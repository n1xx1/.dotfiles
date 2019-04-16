


set history=500

" filetype plugins
filetype plugin on
filetype indent on

" autoread when file is changed from outside
set autoread

let mapleader = ","
nmap <leader>w :w!<cr>
command W w !sudo tee % > /dev/null

set so=7

let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu
set wildignore=*.o;*~,*.pyc
if has("win16") || has("win32") 
	set wildignore+=.git\*,.hg\*,.svn\*
else 
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set nu
set rnu

" show current position
set ruler

" command bar height
set cmdheight=2

set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" ignore case in search
set ignorecase

" smartcases for search
set smartcase

" hightlight search
set hlsearch

set incsearch

set lazyredraw

" regular expressions
set magic

" show matching brackets
set showmatch
set mat=2

" no bell sound
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" extra left margin
set foldcolumn=1

" enable syntax
syntax enable

try
    colorscheme desert
catch
endtry

set background=dark

set encoding=utf8

set ffs=unix,dos,mac

" backup off, useless
set nobackup
set nowb
set noswapfile

" use spaces
set expandtab

" smarttabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" linebreak on 500 chars
set lbr
set tw=500

set ai " auto indent
set si " smart indent
set wrap " wrap lines

" visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" smart search
map <space> /
map <c-space> ?

map <silent> <leader><cr> :noh<cr>

" move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-w>l

" close all buffers
map <leader>ba :bufdo bd<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" manage tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" 'tl' to toggle between last access tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab = tabpagenr()

" opens tab with current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" switch CWD to directory of open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

try 
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" return to last edit position when opening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" always show status line
set laststatus=2
" format
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" remap 0 to first non blank
map 0 ^

" move a line with ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setreg('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.cofee,*.ts :call CleanExtraSpaces()
endif

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

