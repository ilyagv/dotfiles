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


" Disable 'Ex mode'
" nnoremap Q <Nop>

" remove auto commenting
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"set wildignore+=*.o,*.d,*.ko,*.mod.c

" autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/", expand('<cword>'))
autocmd CursorMoved *.c,*.cpp,*.hpp,*.h,*.py,*.rs silent! exe printf("match Search /\\<%s\\>/", expand('<cword>'))
" Save file on disk only when there are changes
nnoremap <leader>w :update<cr>
" Save file in insert mode
inoremap <leader>w <Esc>:update<cr>gi

call plug#begin()
Plug 'nvim-lualine/lualine.nvim' " Statusline
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} " Terminal
Plug 'https://github.com/nvim-telescope/telescope.nvim' " Telescope fuzzing search
Plug 'navarasu/onedark.nvim' " Colorscheme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " Colorscheme
Plug 'nvim-neo-tree/neo-tree.nvim' "File explorer
Plug 'https://github.com/nvim-tree/nvim-tree.lua' " Next file explorer (let's leave it for comparison)
Plug 'vifm/vifm.vim' " Vifm file manager
Plug 'dense-analysis/ale' " Linter
Plug 'numToStr/Comment.nvim' " commenting plugin
Plug 'lukas-reineke/indent-blankline.nvim' " Show identation guides
" Markdown preview in brower plugin
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Search plugins
Plug 'mileszs/ack.vim' " Use Ack search tool
" Rg, Ag and other (BCommits, Files, GFiles ...)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'nvim-pack/nvim-spectre' " Search and replace

" Git plugins
Plug 'junegunn/gv.vim' " A git commit browser (too simple)
" a Vim/Neovim plugin to reveal the hidden message from Git under the cursor quickly
" To open message use '<Leader>gm' two times
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'

Plug 'MunifTanjim/nui.nvim' " UI Component Library (Popups and etc.)
" (Provides Nerd Font 1 icons (glyphs) for use by Neovim plugins. A lua fork of vim-devicons)
Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/lsp-trouble.nvim'
Plug 'nvim-treesitter/nvim-treesitter' " Syntax highlight
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" A completion engine plugin
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp' " Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Rust
Plug 'rust-lang/rust.vim'

" Mason is a plugin to install and manage LSP servers, debuggers and linters
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'simrat39/rust-tools.nvim'
call plug#end()

lua <<EOF
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF

"lua require('gitblame').setup {
"    \ enabled = false,
"\}
lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    opts = { use_diagnostic_signs = true },
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)

local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})
-- Automatically Open Trouble Quickfix
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})
EOF

lua <<EOF
-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ' '})
--sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignWarn', text = ' '})
sign({name = 'DiagnosticSignHint', text = '💡'})
sign({name = 'DiagnosticSignInfo', text = ' '})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

EOF

lua <<EOF

EOF

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

let g:onedark_config = {
    \ 'style': 'deep',
\}
colorscheme onedark
    "\ 'style': 'darker',
    "\ 'style': 'deep',

autocmd VimEnter * TSEnable highlight


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
		'*.py', '*.c', '*.h', '*.rs', 'init.vim', '.vimrc'
	},
	callback = function()
		vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
	end,
})
EOF
