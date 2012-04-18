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
" Black background, please
set background=dark
" My favourite syntax colorscheme (iterm 256 colors)
set t_Co=256
color ir_black

" Line numbering
set number
" Show the cursor position all the time
set ruler
set cursorline

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

set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.

" == Status bar
" Always show the status bar
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{fugitive#statusline()}
" Change background color of status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=darkred gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=darkblue gui=bold,reverse
endif

" makes work arrows in visual mode
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" == Ruby block ==
runtime macros/matchit.vim

" == CtrlP ==
let g:ctrlp_map = '<leader>l'
map <leader>. :CtrlPMRU<CR>
let g:ctrlp_match_window_reversed = 0
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/tmp/*

" == DestroyAllSoftware tips ==

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" leader-f for Ack
map <leader>f :Ack<space>

" leader-r for greplace
map <leader>r :Gqfopen<CR>:ccl<CR>

" Open routes.rb
map <leader>gr :topleft :split config/routes.rb<cr>

" Open Gemfile
map <leader>gg :topleft 100 :split Gemfile<cr>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Can't be bothered to understand the difference between ESC and <c-c> in
" insert mode
imap <c-c> <esc>

" == Split windows ==
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

" == ChooseColor ==
map <leader>c :ChooseColor<CR>
imap <leader>c <Esc>:ChooseColor<CR>

" == Highlight long lines ==
highlight OverLength ctermbg=black guibg=#592929
match OverLength /\%81v.\+/

" == iTermux ==
" let g:itermux_session_name = 'vimterm'

" == Map jj to Esc ==
inoremap jj <Esc>

" == Paste from clipboard ==
vmap <leader>y "*y
nmap <leader>p :set paste<CR>"*p:set nopaste<CR>

" == Current line highlighter ==
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline
hi CursorLine cterm=NONE ctermbg=0 guibg=darkred

" == %% gets converted to "directory of current file" ==
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" == Prefills :edit command with the current dir ==
map <leader>e :edit %%

" == Rename the current file! ==
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

