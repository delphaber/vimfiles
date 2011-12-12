" The set nocompatible setting makes vim behave in a more useful way (the default) than the vi-compatible manner.
set nocompatible
" Enable syntax highlighting
syntax enable
" Default charset encoding
set encoding=utf-8

" Pathogen initialization
call pathogen#infect()
filetype plugin indent on

" Leader key
let mapleader=","
" Black background, please
set background=dark
" My favourite syntax colorscheme
color ir_black

" Line numbering
set number
" Show the cursor position all the time
set ruler
set cursorline

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
:nnoremap <CR> :nohlsearch<cr>

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
set scrolloff=3

" Removes trailing spaces
function KillWhitespace()
  %s/\s*$//
  ''
:endfunction

" Automatically remove trailing spaces on some files
autocmd FileWritePre * :call KillWhitespace()
autocmd FileAppendPre * :call KillWhitespace()
autocmd FilterWritePre * :call KillWhitespace()
autocmd BufWritePre * :call KillWhitespace()
map <F2> :call KillWhitespace()<CR>
map! <F2> :call KillWhitespace()<CR>

set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.

" == Status bar
" Always show the status bar
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{fugitive#statusline()}

" == Command-T
let g:CommandTMaxHeight=20

" makes work arrows in visual mode
vnoremap <Left> h
vnoremap <Right> l
vnoremap <Up> k
vnoremap <Down> j

" Close all buffers but the current one
map <F2> :call KillWhitespace()<CR>
map! <F2> :call KillWhitespace()<CR>
