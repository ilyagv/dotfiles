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
" Plug 'https://github.com/vim-airline/vim-airline'
Plug 'nvim-lualine/lualine.nvim' " Statusline
Plug 'https://github.com/preservim/nerdtree'
" Plug 'https://github.com/ryanoasis/vim-devicons'
" Plug 'https://github.com/nvim-lua/plenary.nvim'
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
Plug 'dense-analysis/ale'	" Linter
Plug 'sindrets/diffview.nvim'
Plug 'vifm/vifm.vim'
"Plug 'f-person/git-blame.nvim'
Plug 'rhysd/git-messenger.vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'rhysd/git-messenger.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'lukas-reineke/indent-blankline.nvim' " Show identation guides
Plug 'numToStr/Comment.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'nvim-pack/nvim-spectre'

" A completion engine plugin
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Rust
Plug 'rust-lang/rust.vim'
call plug#end()

"lua require('gitblame').setup {
"    \ enabled = false,
"\}

lua <<EOF
-- local lsp = require('lspconfig')
-- local completion = require('completion')
--
-- local custom_attach = function()
--     completion.on_attach()
--     -- Python specifically isn't setting omnifunc correctly, ftplugin conflict
--     vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
-- end
--
-- lsp.pylsp.setup{on_attach=custom_attach}
--
-- --" neovim LSP Configuration
-- require('lua_config')

EOF

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

        -- For `mini.snippets` users:
        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
        -- insert({ body = args.body }) -- Insert at cursor
        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
        -- require("cmp.config").set_onetime({ sources = {} })
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }
EOF

lua << EOF

require('lualine').setup({
	options = {
		theme = 'onedark',
	},
})

require('nvim-web-devicons').setup()

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

nnoremap <leader>mp <cmd>MarkdownPreview<cr>
nnoremap <leader>ms <cmd>MarkdownPreviewStop<cr>

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
