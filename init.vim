set termguicolors
call plug#begin('~/.vim/plugged')

set number " Line Numbers

colorscheme stereokai

Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-vividchalk'
Plug 'roxma/vim-tmux-clipboard'
Plug 'fatih/vim-go'
Plug 'dkprice/vim-easygrep'
Plug 'christoomey/vim-tmux-navigator'  " Navigate between tmux panes and vim splits
Plug 'ntpeters/vim-better-whitespace'
Plug 'zchee/deoplete-jedi'
Plug 'hashivim/vim-terraform'

let g:terraform_align=1

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'fishbullet/deoplete-ruby'

let g:deoplete#enable_at_startup = 1

" Ruby
Plug 'vim-ruby/vim-ruby'

" Run tests
Plug 'janko-m/vim-test'


call plug#end()

nmap <silent> <leader>T :TestFile<CR>

set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set expandtab         " Expand tabs to spaces
set showmatch   		  " Show matches
set ts=2 	      			" Tab is 2 spaces
set shiftwidth=2      " Indents are 2 spaces
let mapleader = " " 	" Leader is space bar
map <Leader>n :NERDTreeToggle<CR>
set clipboard=unnamed " TMUX/VIM COPY PASTE
set encoding=utf8

" Clear search/highlights by ctrl+L
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

autocmd BufEnter * EnableStripWhitespaceOnSave

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Show 80 char mark
let &colorcolumn=join(range(99,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

