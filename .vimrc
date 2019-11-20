" Plugins
call plug#begin('~/.vim/plugged') 
Plug 'dracula/vim', { 'as': 'dracula' } 
" Initialize plugin system
call plug#end()

" Make CTRL+C copy to system clipboard on Linux
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

syntax on
set visualbell
"set tabs to 4 spaces
set ts=4
"set autoindenting
set ai
"show matching brackets
set showmatch
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

"start the window taller
"set lines=50
"and wider
"set co=91

"show line numbers
"set number
"just show a summary in the bottom R corner
set ruler

"fold at indents
"set fdm=indent

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

"The rest deal with whitespace handling and
"mainly make sure hardtabs are never entered
"as their interpretation is too non standard in my experience
set softtabstop=4
" Note if you don't set expandtab, vi will automatically merge
" runs of more than tabstop spaces into hardtabs. Clever but
" not what I usually want.
set expandtab
set shiftwidth=4
set shiftround
set nojoinspaces

""""""""""""""""""""""""""""""""""""""""""""""""
" Dark background
""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme dracula

""""" Hide elements of the gvim gui
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

""""" Include a left margin
set foldcolumn=2
