" Plugins
call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'preservim/nerdtree'
Plug 'neovim/nvim-lspconfig'

" Integrated testing with Pytest
Plug 'alfredodeza/pytest.vim'

" Iceberg color scheme
Plug 'cocopon/iceberg.vim'

" Comments
Plug 'preservim/nerdcommenter'

" Git integration
Plug 'tpope/vim-fugitive'

" Git markers in the side column
Plug 'airblade/vim-gitgutter'

" " info bar at the bottom
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Status line
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Surround something with parens, brackets, quotes, etc
Plug 'tpope/vim-surround'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" " " autocompletion for python
" " Plug 'davidhalter/jedi-vim'

" " " further plugin for autocompletion
" " Plug 'deoplete-plugins/deoplete-jedi'

" Git blame
Plug 'APZelos/blamer.nvim'

" Initialize plugin system
call plug#end()

" map leader to comma
let mapleader = ","

if has("termguicolors")
    set termguicolors
endif

" Make the cursor into a line in insert mode
" In the GUI
if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif
" In a terminal
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set ttimeout
set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Gitgutter settings
" Go to the next/previous hunk using <bracket>+h
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" NerdCommenter settings
" Comment a line in/out with \-c-<space>
filetype plugin on
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" NerdTree settings
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <C-t> :NERDTreeToggle<CR>

let g:airline_theme='tomorrow'

" jedi-vim settings
let g:jedi#use_tabs_not_buffers = 1

" yank to system clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Improved python syntax highlighting with vim-python/python-syntax
let g:python_highlight_all = 1

" General settings
set mouse=a
syntax on
colorscheme iceberg
set visualbell
set showmatch "show matching brackets
hi MatchParen cterm=bold ctermbg=19 ctermfg=212 guibg=#bec0c9 guifg=#33374c
" make that backspace key work the way it should
set backspace=indent,eol,start
"highlight search terms
set hlsearch
"dynamically
set incsearch
" Press Space to turn off highlighting and clear any message already displayed.
:noremap <silent> <Space> :silent noh<Bar>echo<CR>
" searching in uppercase is case-sensitive, while in lowercase isn't
set smartcase

" Make searches use regex by default
nnoremap / /\v
vnoremap / /\v

" Strip all trailing whitespace in the file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Escape using jj
inoremap jj <ESC>

" the following line prevents forcing # to be inserted in column 1
" If you use compatible, then ensure < is not in cpoptions: cpoptions-=<
inoremap # X<BS>#

""""""""""""""""""""""""""""""""""""""""""""""""
" Set up tab completion in insert mode
""""""""""""""""""""""""""""""""""""""""""""""""
"from http://www.vim.org/tips/tip.php?tip_id=102
function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
     else
         return "\<c-p>"
     endif
endfunction

"then define the appropriate mapping:
inoremap <tab> <c-r>=InsertTabWrapper()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""
" Indenting
""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent
set smartindent
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround
set nojoinspaces
set fileformat=unix


"""""""""""""
" Lua setup "
"""""""""""""

lua << END
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '•', right = '•'},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require'lspconfig'.pylsp.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 100
        }
      }
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').setup{
    pickers = {
        find_files = {
            theme = "dropdown",
        }
    },
    extensions = {
        find_files = {
            theme = "dropdown",
        }
    },
}
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

END
