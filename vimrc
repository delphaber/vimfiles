" The set nocompatible setting makes vim behave in a more useful way (the default) than the vi-compatible manner.
set nocompatible

" Enable syntax highlighting
syntax enable

" Make tab completion for files/buffers act like bash
set wildmenu

" Default charset encoding
set encoding=utf-8

" Pathogen initialization
call pathogen#infect()
filetype plugin indent on

" Leader key
let mapleader=","

set t_Co=256
set background=dark
color molokai
" let g:molokai_original = 1

" Line numbering
set number
" Show the cursor position all the time
set ruler
set cursorline

" TRICKS
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" === NERDTREE ===
" autocmd vimenter * NERDTree
nmap <silent><leader>t :NERDTreeToggle<CR>
let g:NERDTreeMouseMode = 3
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeShowBookmarks = 0

" I like the mouse
set mouse=a

" Display incomplete commands
set showcmd

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" == Whitespace ==
" Don't wrap lines
set nowrap
" A tab is two spaces
set tabstop=2
" An autoindent (with <<) is two spaces
set shiftwidth=2
" Use spaces, not tabs
set expandtab
" Show invisible characters
set list
" backspace through everything in insert mode
set backspace=indent,eol,start    " List chars
" Reset the listchars
set listchars=""
" A tab should display as "  ", trailing whitespace as "·"
set listchars=tab:\ \
 " Show trailing spaces as dots
set listchars+=trail:·
" The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<

" == Searching ==
" Highlight matches
set hlsearch
" Incremental searching
set incsearch
" Searches are case insensitive...
set ignorecase
" ...unless they contain at least one capital letter
set smartcase
" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" Wrap text automatically setup
function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

if has("autocmd")
  " Make sure all mardown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

  " Movefile is Yaml
  au BufRead,BufNewFile {Movefile}    set ft=yaml

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

" provide some context when editing
set scrolloff=5

" remove whitespaces
command! KillWhitespace :normal :%s/\s\+$//e<cr><c-o><cr>

set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.

" makes work arrows in visual mode
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" navigation between buffers
nmap <silent> <S-left> :bp<CR>
nmap <silent> <S-right> :bn<CR>

nmap <silent> <leader>b :buffers<CR>

" == Powerline ==
" always show status bar
set laststatus=2

let g:Powerline_symbols = 'fancy'

" == Ruby block ==
runtime macros/matchit.vim

" == CtrlP ==
let g:ctrlp_map = '<leader>l'
map <leader>. :CtrlPBufTag<CR>
map <leader>- :CtrlPBuffer<CR>
map <leader>u :CtrlPUndo<CR>
let g:ctrlp_match_window_reversed = 0
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/tmp/*
let g:ctrlp_extensions = ['buffertag', 'undo']
let g:ctrlp_root_markers = ['root.dir']

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" leader-f for Ack
map <leader>f :Ack<space>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Can't be bothered to understand the difference between ESC and <c-c> in
" insert mode
imap <c-c> <esc>

" == Paste from clipboard ==
vmap <leader>y "+y
nmap <leader>p :set paste<CR>"+p:set nopaste<CR>

" == Split Join ==
nmap sj :SplitjoinJoin<CR>
nmap ss :SplitjoinSplit<CR>

" == %% gets converted to "directory of current file" ==
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" == ACK == "
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
