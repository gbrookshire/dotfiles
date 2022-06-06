" Plugins
call plug#begin('~/.vim/plugged')

" Iceberg color scheme
Plug 'cocopon/iceberg.vim'

" Comments
Plug 'preservim/nerdcommenter'

" Git integration
Plug 'tpope/vim-fugitive'

" Syntastic
Plug 'vim-syntastic/syntastic'

" Git markers in the side column
Plug 'airblade/vim-gitgutter'

" info bar at the bottom
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" " autocompletion for python
" Plug 'davidhalter/jedi-vim'

" " further plugin for autocompletion
" Plug 'deoplete-plugins/deoplete-jedi'

" Initialize plugin system
call plug#end()

" map leader to comma
" let mapleader = ","

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

" Syntastic settings
let g:syntastic_shell = "/bin/sh"
let g:syntastic_python_checkers = ['flake8', 'python3']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_loc_list_height = 5
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args = "--max-line-length=100"
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

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

":help i_CTRL-R

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
