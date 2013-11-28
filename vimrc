call pathogen#infect()
call pathogen#helptags()

"" Sane defaults
set encoding=utf-8
let &t_Co=256                     " moar colors
set clipboard=unnamedplus         " use system clipboard
set nocompatible                  " nocompatible is good for humans
syntax enable                     " enable syntax highlighting...
filetype plugin indent on         " depending on filetypes...
runtime macros/matchit.vim        " with advanced matching capabilities
set pastetoggle=<F12>             " for pasting code into Vim

"" Style
set background=dark
let g:molokai_original = 1
color molokai
set number                        " line numbers are cool
set ruler                         " show the cursor position all the time
set nocursorline                  " disable cursor line
set showcmd                       " display incomplete commands
set novisualbell                  " no beeps please
set scrolloff=3                   " provide some context when editing
set hidden                        " Allow backgrounding buffers without writing them, and
                                  " remember marks/undo for backgrounded buffers
"" Mouse
set nomousehide                   " fix problem with cursor and ubuntu?
set mouse=a                       " we love the mouse

"" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set softtabstop=2                 " when deleting, treat spaces as tabs
set expandtab                     " use spaces, not tabs
set list                          " show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set autoindent                    " keep indentation level when no indent is found

"" Wild life
set wildmenu                      " wildmenu gives autocompletion to vim
set wildmode=list:longest,full    " autocompletion shouldn't jump to the first match
set wildignore+=tmp/**,*.rbc,.rbx,*.scssc,*.sassc,*.pyc,*.xls

"" List chars
set listchars=""                  " reset the listchars
set listchars=tab:▸\ ,eol:¬       " a tab should display as "▸ ", end of lines as "¬"
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " the character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " the character to show in the first column when wrap is
                                  " off and the line continues beyond the left of the screen

"" Per project vimrc
set exrc
set secure

"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " unless they contain at least one capital letter

"" Windows
set splitright                    " create new horizontal split on the right
set splitbelow                    " create new vertical split below the current window
" set winheight=5                   " set winheight to low number...
" set winminheight=5                " or this will fail
" set winheight=999
" set winwidth=84

"" Other 
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slight delay after pressing ESC then O
set autoread " auto reload buffer if file has been changed

"" Code conventions
if has("autocmd")
  " in Makefiles use real tabs, not tabs expanded to spaces
  au FileType make setl ts=8 sts=8 sw=8 noet

  " make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

  " treat JSON files like JavaScript
  au BufNewFile,BufRead *.json setf javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python,htmldjango setl sts=4 ts=4 sw=4

  " delete Fugitive buffers when they become inactive
  au BufReadPost fugitive://* set bufhidden=delete

  " remember last location in file, but not for commit messages,
  " or when the position is invalid or inside an event handler,
  " or when the mark is in the first line, that is the default
  " position when opening a file. See :help last-position-jump
  au BufReadPost *
    \ if &filetype !~ '^git\c' && line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

"" GO
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on

"" Backup and status line
set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.
set laststatus=2

"" Mappings! Set <Leader> key
let mapleader=","

" disable man page for word under cursor
nnoremap K <nop>

" y u consistent?
function! YRRunAfterMaps()
  nnoremap <silent> Y :<C-U>YRYankCount 'y$'<CR>
endfunction

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

" expand %% to current directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" edit file in the same directory of current file
map <Leader>e :e %%

" easy way to switch between latest files
nnoremap <Leader><Leader> <C-^>

" find merge conflict markers
nmap <silent> <Leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" toggle list mode
nmap <silent> <Leader>s :set nolist!<CR>

" copy current path
nmap <silent> <Leader>p :let @* = expand("%")<CR>

" easy substitutions
nmap <Leader>r :%s///gc<Left><Left><Left><Left>
nmap <Leader>R :%s:::gc<Left><Left><Left><Left>

" remove whitespaces and windows EOL
command! KillWhitespace :normal :%s/\s\+$//e<CR><C-O><CR>
command! KillControlM :normal :%s/<C-V><C-M>//e<CR><C-O><CR>

" easier navigation between split windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

"" Fugitive
map <Leader>gs  :Gstatus<CR>
map <Leader>gd  :Gdiff<CR>
map <Leader>gci :Gcommit<CR>
map <Leader>gw  :Gwrite<CR>
map <Leader>gr  :Gread<CR>

"" Plugins mapping
map <silent> <S-left> <Esc>:bp<CR>
map <silent> <S-right> <Esc>:bn<CR>
map <Leader>n :NERDTreeToggle<CR>
map <Leader>u :GundoToggle<CR>
vmap <Leader>z :call I18nTranslateString()<CR>
nnoremap <leader>t :call RunCurrentSpecFile()<cr>
nnoremap <leader>T :call RunNearestSpec()<cr>
nnoremap <leader>A :call RunAllSpecs()<cr>

"" Bad behaviours
xnoremap u <Nop>

"" Plugins configuration
let g:ctrlp_map = '<leader>f'
map <leader>- :CtrlPBufTag<CR>
map <leader>. :CtrlPBuffer<CR>
let g:ctrlp_match_window_reversed = 0
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/tmp/*,*/node_modules/*
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_root_markers = ['root.dir']
let g:NERDTreeMouseMode = 3
let g:NERDTreeHighlightCursorline = 0
let g:gundo_right = 1
let g:Powerline_symbols = 'fancy'
let g:vdebug_options = { "break_on_open" : 0 }
let g:rspec_command="!t {spec}"

" Convert hashrockets into new 1.9 hash syntax
noremap <leader>rr :%s/:\(\w\+\)\s*=>/\1:/ge<CR><C-o>
" Remove space inside square brackets
noremap <leader>zz :%s/\[\s\+\([^\]]\+\)\s\+\]/[\1]/ge<CR><C-o>
