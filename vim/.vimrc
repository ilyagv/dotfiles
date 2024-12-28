set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}
     
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'mru.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround' 
Plugin 'xml.vim'
Plugin 'noah/vim256-color'
Plugin 'lifepillar/vim-solarized8'
Plugin 'kien/ctrlp.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'hari-rangarajan/CCTree'

"Plugin 'Valloric/YouCompleteMe' // only vim 7.4+

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set number
syntax on
set title
set laststatus=2

set ignorecase
set hlsearch
set nowrap
"set tags=/home/ilya/source/linux-3.10.12/tags
"set fileencoding=utf-8,cp1251,cp866,koi8-r
map <F3> :NERDTreeToggle<CR>
map <F4> :TagbarToggle<CR>
map <Tab> :bn<CR>

let g:tagbar_left=0

if has('gui_running')
     set background=dark
	"colorscheme oceandeep
     colorscheme solarized8
	set guifont=Monospace\ 13
     "set guifont=Courier\ New\ 13

     set guioptions-=r "remove scroll right
     set guioptions-=l "remove scroll left
"     set guioptions-=m "no menu
     set guioptions-=T "no toolbar
else
     if has('termguicolors')
          set termguicolors
          set background=dark
          "echo &t_Co
          "colorscheme Tomorrow-Night
          "colorscheme oceandeep
          colorscheme solarized8
     else
          set background=dark
          set t_Co=256
          "colorscheme torte
          "colorscheme hybrid
          colorscheme Tomorrow-Night
     endif 
endif

"set encoding=cp1251
"set fileencoding=cp1251

set fileencodings=utf-8,cp1251,koi8-r,cp866

menu Encoding.koi8-r :e ++enc=koi8-r ++ff=unix<CR>
menu Encoding.windows-1251 :e ++enc=cp1251 ++ff=dos<CR>
menu Encoding.cp866 :e ++enc=cp866 ++ff=dos<CR>
menu Encoding.utf-8 :e ++enc=utf8<CR>
menu Encoding.koi8-u :e ++enc=koi8-u ++ff=unix<CR>

map <F8> :emenu Encoding.<TAB>

set colorcolumn=81
set listchars=tab:»\ ,trail:.,extends:»,precedes:«

" It's InfoTeCS settings
"set tabstop=5
"set shiftwidth=5
"set expandtab

" Linux kernel settings
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

set smarttab

"set lines=45
"set columns=195
set cursorline
set cursorcolumn
set mouse=a
set autoread

set hlsearch
set incsearch
set showmatch
set ignorecase
set scrolloff=3
set sidescrolloff=5
set showcmd
set wildmenu

set clipboard=unnamedplus
"set clipboard+=unnamed  " use the clipboards of vim and win
set paste               " Paste from a windows or from vim
set go+=a               " Visual selection automatically copied to the clipboard


let NERDTreeIgnore = ['\.o$', '\.d$', '\.ko$', '\.mod\.c$']
let g:NERDTreeWinSize=40

" Disable 'Ex mode' 
nnoremap Q <Nop>

" remove auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set wildignore+=*.o,*.d,*.ko,*.mod.c

autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/", expand('<cword>'))


"Save file using Ctrl+S in different modes
nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <c-s> <Esc>:update<CR>l " Exit from insert mode and save file
" inoremap <silent> <c-s> <c-o>:update<CR> " Save file and return to insert mode
"vnoremap <silent> <C-S> <C-O>:update<CR>

" set lines=9999
" set columns=999
