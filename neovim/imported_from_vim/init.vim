" Installed via jni-dot-files
"
" Ignore when installed via jni-dot-files:
"
" Place this file as .vimrc in your home folder
" Use this to have it for root as well sudo cp  /root/.vimrc
" 
" (1) Install vim-plugin manager:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" (2) Install the plugins with ':PlugInstall'
" 
"
"
" P L U G I N S   O V E R V I E W 
"
" (1) Nerdcommenter
" 	A language sensitive commenting helper
" 	Use <Space> plus c plus <Space> to toggle commenting.
"
" (2) Autocomplete Popup
" 	This plugin will automatically pop up autocompletion
" 	Use <Ctrl> plus 'p' for autocomplete (word spelling)
"	When the menu is shown...
"		right arrow or Tabulator will select the item.
"		left arrow will make the autocompletion menu disappear
"		arrows up and down will navigate over the items.
" (3) Undotree
" 	Make sure to create mkdir -p ~/.vim/undodir
" 	Call it by <Space> plus 'u' (custom binding)
"
" (4) fzf
" 	Call it by <Ctrl> plus 'f' inside a file (custom binding)
" 	Call <Space> plus 'f" to find a file (custom binding)	
"
" (5) lightline
" 	It's just a the nicer status bar at the bottom
"
" (6) Gruvbox
" 	Custom vim theme
"
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/AutoComplPop'
Plug 'tpope/vim-surround'
call plug#end()


" S E T T I N G S

set nocompatible
syntax enable
filetype plugin on

color gruvbox
set background=dark

hi Normal guibg=NONE ctermbg=NONE

set number relativenumber
set nu rnu
set nowrap
set cursorline
hi CursorLine   cterm=NONE ctermbg=black
hi CursorLineNr cterm=bold ctermfg=black ctermbg=yellow
hi LineNr cterm=none ctermfg=darkgrey

" " Exchange all tabs with 4 spaces:
" set tabstop=4
" set softtabstop=0
" set noexpandtab
" set shiftwidth=4

" Use just tabs with the length of 4 spaces
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
" Force the aboth settings for the listed filetypes
autocmd FileType c,cpp,java,python setlocal noet ci pi sts=0 sw=4 ts=4

set hlsearch
set incsearch
set ignorecase
set smartcase

set path+=**
set wildmenu
set wildignore+=**/node_modules/**

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" For autocompletion (Spell checking, needs to be triggerd by <Ctrl> plus p)
set complete+=kspell
" Show auto completion if there is only option, preselect the longest suggestion
set completeopt=menuone,longest
" Do not mess with the status bar when auto completing
set shortmess+=c

" To enable Ligtline (the bar at the bottom)
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

" Necessary to allow man vim, when vim is defined as man page viewer
let $PAGER=''

set shiftwidth=4
set splitbelow
set splitright
set scrolloff=8
set updatetime=250
set encoding=UTF-8
set mouse=a
set colorcolumn=80
set showtabline=2

" Settings for Nerdcommenter
"
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
let g:NERDTrimTrailingWhitespace = 0

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1



" K E Y   R E M A P P I N G S
" nnoremap explenation: 'n' for normal mode 'nore' for not recursive and 'remap' for remapping
"
" Remap leader key to space
let mapleader=" "


" Fix to use normal cursor keys via SSH
" Source (Solution 15) : https://vim.fandom.com/wiki/Fix_arrow_keys_that_display_A_B_C_D_on_remote_shell
imap <ESC>oA <ESC>ki
imap <ESC>oB <ESC>ji
imap <ESC>oC <ESC>li
imap <ESC>oD <ESC>hi

" Move with Space and Nav key to next split
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Resize current split, larger, smaller, equally
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>= :wincmd =<CR>

" Open Undotree
nnoremap <leader>u :UndotreeShow<CR>

" Open FZF File Manager
nnoremap <silent><leader>f :Files .<CR>
" Ctrl + x (horizontal split) 
" Ctrl + v (vertical split),
" Ctrl + t (open in new tab)
" or simply Enter to open in the current buffer.
"
" Working with Tabs
" gt to go to next Tab.
" gT to go to previous Tab.
" <num>gt to got to number tab.
"
" Ctrl + F to FZF search in the current buffer; this overrides the page down binding
nnoremap <silent> <C-f> :BLines<CR>

" Auto Completion Mappings (Insert Mode)
" If the completion menu is visible use the arrow keys (up and down) to
" navigate the shown items.
inoremap <expr> <Down> pumvisible() ? "<C-n>" : "<Down>"
inoremap  <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"
" If the completion menu is visible use Tab or arrow right to select the item 
inoremap  <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap  <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"
" Exit the completion item with escape (when it is shown)
inoremap  <expr> <Esc> pumvisible() ? "<C-e><Esc>" : "<Esc>"

" Map jj to Escape
imap jj <Esc>

" Additions from 2021-12-28

" Remap copy paste to and from system clipboard when in virtual mode
vnoremap <leader>y "+y
nnoremap <leader>y "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Map K to split line at the cursor and stay at the rest of the line
nnoremap K i<CR><Esc>k$

" Leader, leader 'l' will toggle line numbers (and relativenumbers)
nnoremap <leader><leader>l :set nonu!<CR>:set norelativenumber!<CR>

" Capital Y copies right from the cursor until the end of line (like D deletes)
nnoremap Y y$

" Keeping the cursor centered when using search and joining lines.
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Breaking the undo chain on each , . ! ? ; - so that an undo is less painful.
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Show whitespaces with "leader, leader, w" or "F5"
noremap <F5> :set list!<CR>
noremap <leader><leader>w :set list!<CR>
"  inoremap <F5> <C-o>:set list!<CR>
"  cnoremap <F5> <C-c>:set list!<CR>
