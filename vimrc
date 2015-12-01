set nocompatible               " be iMproved

let g:solarized_italic = 0

syntax enable

set hlsearch
set backspace=eol,indent,start
set relativenumber
set autoindent
set showcmd
set showmatch
set showmode
set incsearch
set cursorline
set scrolloff=7
set wildmenu
set magic
set expandtab
set linespace=2
"
" No Backup
set nobackup
set nowritebackup
set noswapfile
" Persistent undo
try
    if MySys() == "windows"
      set undodir=C:\Windows\Temp
    else
      set undodir=~/.vim_runtime/undodir
    endif

    set undofile
catch
endtry

set encoding=utf-8
setglobal fileencoding=utf-8 nobomb
set fileencodings=usc-bom,utf-8,latin1,cp1251

" maps
map <space> /
map <C-space> ?
map <F12> :NERDTreeFocus<CR>
inoremap ;n <Esc>

filetype on
filetype plugin on
filetype plugin indent on

set sidescroll=5
set listchars+=precedes:<,extends:>,trail:·,tab:>-

"set keymap=russian-jcukenwin
set iminsert=0

if has("gui_running")
	colorscheme solarized
  set background=dark
	set guifont=Terminus\ 11
	set guioptions=aegimt
endif
