set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'ap/vim-css-color'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'elixir-lang/vim-elixir'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'majutsushi/tagbar'
Plugin 'marcweber/vim-addon-local-vimrc'
Plugin 'mattreduce/vim-mix'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'mbbill/undotree'
Plugin 'mileszs/ack.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'pangloss/vim-javascript'
Plugin 'raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'shougo/neocomplete.vim'
Plugin 'slim-template/vim-slim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thinca/vim-visualstar'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'

call vundle#end()

filetype plugin indent on
set encoding=utf-8
let &t_Co=256                     " moar colors
set clipboard=unnamed             " use system clipboard
syntax enable                     " enable syntax highlighting...
runtime macros/matchit.vim        " with advanced matching capabilities
set pastetoggle=<F12>             " for pasting code into Vim

"" Style
set background=dark
let g:rehash256 = 1
color molokai
set number                        " line numbers are cool
set relativenumber                " relative numbers
set ruler                         " show the cursor position all the time
set nocursorline                  " disable cursor line
set showcmd                       " display incomplete commands
set novisualbell                  " no beeps please
set scrolloff=3                   " provide some context when editing
set hidden                        " Allow backgrounding buffers without writing them, and
                                  " remember marks/undo for backgrounded buffers
"" Mouse
set nomousehide                   " fix problem with cursor and ubuntu?
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

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
set wildignore+=*.scssc,*.sassc,*.pyc,*.xls
set wildignore+=.git/**,.hg/**,.svn/**,.sass-cache/**,tmp/**,node_modules/**

"" List chars
set listchars=""                  " reset the listchars
set listchars=tab:▸\ ,eol:¬       " a tab should display as "▸ ", end of lines as "¬"
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " the character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " the character to show in the first column when wrap is
                                  " off and the line continues beyond the left of the screen

"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " unless they contain at least one capital letter

"" Windows
set splitright                    " create new horizontal split on the right
set splitbelow                    " create new vertical split below the current window
set winheight=5                   " set winheight to low number...
set winminheight=5                " or this will fail
set winheight=999
set winwidth=84

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

  au BufNewFile,BufRead *.html.erb.deface setf eruby

  au BufNewFile,BufRead *.html.slim.deface setf slim

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

"" Backup and status line
set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.
set laststatus=2

"" Mappings! Set <Leader> key
let mapleader=","

" disable man page for word under cursor
nnoremap K <nop>

" y u consistent?
nmap <silent> Y y$

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

" expand %% to current directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" edit file in the same directory of current file
map <Leader>e :e %%

" easy way to switch between latest files
nnoremap <Leader><Leader> <C-^>

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

nnoremap <leader>t :call RunCurrentSpecFile()<CR>
nnoremap <leader>T :call RunNearestSpec()<CR>
nnoremap <leader>A :call RunAllSpecs()<CR>

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste

map <Leader>n :NERDTreeToggle<CR>

"" Bad behaviours
xnoremap u <Nop>

" Convert hashrockets into new 1.9 hash syntax
command! ConvertRubyHash :normal :%s/:\(\w\+\)\s*=>/\1:/ge<CR><C-O><CR>

" Plugins configuration
" =====================

" Ctrl P
let g:ctrlp_map = '<leader>f'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:NERDTreeMouseMode = 3
let g:NERDTreeHighlightCursorline = 0
let g:yankstack_map_keys = 0
let g:syntastic_ruby_checkers = ['rubocop']
let delimitMate_expand_space = 1

" easymotion/vim-easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " 
map <Leader>. <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" mmbill/undotree
if has("persistent_undo")
  set undodir='~/.undodir/'
  set undofile
endif

" shougo/neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction
