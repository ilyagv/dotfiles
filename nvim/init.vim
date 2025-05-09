set number
set mouse=a
syntax on
set title
set laststatus=2

set ignorecase
set hlsearch
set nowrap

set colorcolumn=81
set listchars=tab:»\ ,trail:.,extends:»,precedes:«

" Linux kernel settings
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

" set smarttab

"set lines=45
"set columns=195
set cursorline
" set cursorcolumn
" set autoread

set hlsearch
set incsearch
set showmatch
set ignorecase
" number of screen lines to keep above and below the cursor (when scrolling)
set scrolloff=10
" set sidescrolloff=5
" set showcmd
" set wildmenu

" set clipboard=unnamedplus
"set clipboard+=unnamed  " use the clipboards of vim and win
" set paste               " Paste from a windows or from vim (this option spoils telescope navigations)
" set go+=a               " Visual selection automatically copied to the clipboard

" PEP 8 identation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \  softtabstop=4
    \  shiftwidth=4
    \  textwidth=79
    \  expandtab
    \  autoindent
    \  fileformat=unix

let NERDTreeIgnore = ['\.o$', '\.d$', '\.ko$', '\.mod\.c$', '\.mod$']
let g:NERDTreeWinSize=40

" Disable 'Ex mode'
" nnoremap Q <Nop>

" remove auto commenting
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"set wildignore+=*.o,*.d,*.ko,*.mod.c

autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/", expand('<cword>'))

call plug#begin()
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/nvim-tree/nvim-tree.lua'
" Plug 'https://github.com/maxmx03/solarized.nvim'
Plug 'https://github.com/shaunsingh/solarized.nvim'
" Plug 'https://github.com/ishan9299/nvim-solarized-lua'
Plug 'https://github.com/lifepillar/vim-solarized8'
"Plug 'https://github.com/Tsuzat/NeoSolarized.nvim'
" Plug 'https://github.com/AlexvZyl/nordic.nvim'
"Plug 'https://github.com/catppuccin/nvim'
"Plug 'https://github.com/rebelot/kanagawa.nvim'
Plug 'https://github.com/mhartington/oceanic-next'
Plug 'https://github.com/EdenEast/nightfox.nvim'
Plug 'https://github.com/rakr/vim-one'
Plug 'https://github.com/pulkomandy/c.vim'
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'https://github.com/akinsho/toggleterm.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'unkiwii/vim-nerdtree-sync'
" Plug 'tpop/fugitive'
Plug 'https://tpope.io/vim/fugitive.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'mileszs/ack.vim'
Plug 'navarasu/onedark.nvim'
Plug 'dense-analysis/ale'
Plug 'sindrets/diffview.nvim'
Plug 'vifm/vifm.vim'
"Plug 'f-person/git-blame.nvim'
Plug 'rhysd/git-messenger.vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'rhysd/git-messenger.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'mfussenegger/nvim-dap'
call plug#end()

"lua require('gitblame').setup {
"    \ enabled = false,
"\}


lua << EOF

require('Comment').setup()

require('neo-tree').setup({
	filesystem = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
	},
})

require('toggleterm').setup({
	 size = function(term)
		 if term.direction == "vertical" then
			return 100
		 elseif term.direction == "horizontal" then
			return 25
		 end
	 end,
 float_opts = {},
})
EOF

lua << EOF
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
-- lua require("ibl").setup()
EOF

"lua require('toggleterm').setup({
"	\ size = 20,
"	\ float_opt = {},
"\})

let g:python3_host_prog = expand('/usr/bin/python3')

map <F3> :Neotree toggle<CR>
" map <F3> :NERDTreeToggle<CR>
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
" map <F4> :TagbarToggle<CR>

map <Tab> :bn<CR>
map <S-Tab> :bp<CR>

" set
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
"
"nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm size=25"<CR>
"inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm size=25"<CR>

" nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
" inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

"lua require('telescope').setup({ defaults = { layout_config = { vertical = { width = 0.5 } }, }, })

lua << EOF
require('telescope').setup({
	defaults = {
		layout_config = {
			horizontal = {
				prompt_position = "top",
				width = {
					padding = 0
				},
				height = {
					padding = 0
				},
				preview_width = 0.5,
			},
		},
	},
})
EOF

"lua require('telescope').load_extension("live_grep_args")

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>

" Example config in Vim-Script
" let g:solarized_italic_comments = v:true
" let g:solarized_italic_keywords = v:false
" let g:solarized_italic_functions = v:false
" let g:solarized_italic_variables = v:false
" let g:solarized_contrast = v:true
" let g:solarized_borders = v:false
" let g:solarized_disable_background = v:false
" let g:solarized_extra_hi_groups = 1



" colorscheme solarized8
" colorscheme terafox
"colorscheme carbonfox
"colorscheme dawnfox
"colorscheme dayfox
"colorscheme duskfox
"colorscheme nightfox
"colorscheme nordfox

" colorscheme terafox
let g:onedark_config = {
    \ 'style': 'deep',
\}
colorscheme onedark
    "\ 'style': 'darker',
    "\ 'style': 'deep',

autocmd VimEnter * TSEnable highlight

let g:nerdtree_sync_cursorline = 1
let g:NERDTreeHighlightCursorline = 1


"" Build a quickfix list when multiple files are selected
"function! s:build_quickfix_list(lines)
"  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
"  copen
"  cc
"endfunction
"
"let g:fzf_action = {
"  \ 'ctrl-x': function('s:build_quickfix_list'),
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-h': 'split',
"  \ 'ctrl-v': 'vsplit' }
let g:fzf_preview_window=['up:80%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 1.0, 'relative': v:true } }


lua << EOF
--  Highlight trailing whitespaces
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "darkred", bg = "darkred" })

-- Autocommand to highlight trailing whitespace in all buffers
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = {
		'*.py', '*.c', '*.h', 'init.vim', '.vimrc'
	},
	callback = function()
		vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
	end,
})
EOF
