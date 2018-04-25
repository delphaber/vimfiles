" Vundle {{{
  set nocompatible
  filetype off

  set rtp+=~/.vim/bundle/Vundle.vim
  set rtp+=/usr/local/opt/fzf
  call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'

  Plugin 'benmills/vimux'
  Plugin 'christoomey/vim-tmux-navigator'
  Plugin 'ervandew/supertab'
  Plugin 'godlygeek/tabular'
  Plugin 'janko-m/vim-test'
  Plugin 'junegunn/fzf.vim'
  Plugin 'lfv89/vim-interestingwords'
  Plugin 'marcweber/vim-addon-local-vimrc'
  Plugin 'maxbrunsfeld/vim-yankstack'
  Plugin 'mileszs/ack.vim'
  Plugin 'morhetz/gruvbox'
  Plugin 'nathanaelkane/vim-indent-guides'
  Plugin 'rizzatti/dash.vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'sheerun/vim-polyglot'
  Plugin 'terryma/vim-multiple-cursors'
  Plugin 'thinca/vim-visualstar'
  Plugin 'tpope/vim-abolish'
  Plugin 'tpope/vim-commentary'
  Plugin 'tpope/vim-endwise'
  Plugin 'tpope/vim-eunuch'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-markdown'
  Plugin 'tpope/vim-ragtag'
  Plugin 'tpope/vim-rails'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-rhubarb'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-unimpaired'
  Plugin 'tpope/vim-vinegar'
  Plugin 'vim-airline/vim-airline'
  Plugin 'w0rp/ale' " ALE (Asynchronous Lint Engine)
  Plugin 'zhaocai/GoldenView.Vim'

  call vundle#end()
" }}}

" General {{{
  filetype plugin indent on
  syntax on
  set mouse=a                                 " enable the use of the mouse in all modes
  if !has('nvim')
    set ttymouse=xterm2                       " and we want it to be fast
  endif
  set encoding=utf-8                          " sets the character encoding used inside Vim
  set clipboard^=unnamed,unnamedplus
  set hidden                                  " allow backgrounding buffers without writing them
  set timeout timeoutlen=1000 ttimeoutlen=10  " fix delay after pressing ESC
  set autoread                                " auto reload buffer if file has been changed
  set nobackup                                " disable backup files...
  set noswapfile                              " and swap files
  runtime macros/matchit.vim
" }}}

" VIM UI {{{
  color gruvbox
  colorscheme gruvbox
  " let g:rehash256 = 1
  let g:gruvbox_contrast_dark='hard'
  " let g:airline_theme='gruvbox'
  set background=dark

  set cursorline                  " highlight the screen line of the cursor
  set noshowmode                  " do not show vim mode in the last line of the screen
  set showcmd                     " show (partial) command in the last line of the screen
  set number                      " precede each line with its line
  set backspace=indent,eol,start  " backspace through everything in insert mode
  set laststatus=2                " always show a status line

  set incsearch  " incremental searching
  set hlsearch   " highlight matches
  set ignorecase " searches are case insensitive...
  set smartcase  " unless they contain at least one capital letter

  set wildmenu                    " enable command-line completion
  set wildmode=list:longest,full  " autocompletion shouldn't jump to the first match
  set wildignore+=.git/**,.svn/**,.sass-cache/**,tmp/**,node_modules/**

  set scrolljump=5 " minimal number of lines to scroll when the cursor gets off the screen
  set scrolloff=5  " minimal number of screen lines to keep above and below the cursor
  set splitright   " puts new vsplit windows to the right of the current
  set splitbelow   " puts new split windows to the bottom of the current

  set list                                       " show invisible characters
  set listchars=""                  " reset the listchars
  set listchars=tab:▸\ ,eol:¬       " a tab should display as "▸ ", end of lines as "¬"
  set listchars+=trail:.            " show trailing spaces as dots
  set listchars+=extends:>          " the character to show in the last column when wrap is
                                    " off and the line continues beyond the right of the screen
  set listchars+=precedes:<         " the character to show in the first column when wrap is
                                    " off and the line continues beyond the left of the screen
  set fillchars+=vert:\             " set vertical divider to empty space
" }}}

" Formatting {{{
  set nowrap                      " do not wrap long lines
  set autoindent                  " indent at the same level of the previous line
  set shiftwidth=2                " use indents of 2 spaces
  set expandtab                   " tabs are spaces, not tabs
  set tabstop=2                   " an indentation every 2 columns
  set softtabstop=2               " let backspace delete indent
  set nojoinspaces                " prevents inserting two spaces after punctuation on a join (J)
  set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

  set foldmethod=syntax
  set foldnestmax=10
  set nofoldenable
  set foldlevel=2

  if has("autocmd")
    " make sure all markdown files have the correct filetype set and setup wrapping
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

    " treat JSON files like JavaScript
    au BufNewFile,BufRead *.json setf javascript

    " spree deface support
    au BufNewFile,BufRead *.html.erb.deface setf eruby
    au BufNewFile,BufRead *.html.slim.deface setf slim
    au BufNewFile,BufRead *.js.coffee.erb setf coffee

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
" }}}

  " disable endwise for anonymous functions
  augroup filetype_elixir_endwise
    au!
    au BufNewFile,BufRead *.{ex,exs}
          \ let b:endwise_addition = '\=submatch(0)=="fn" ? "end)" : "end"'
  augroup END

  " disable relative number for unfocused buffers
  " augroup numbertoggle
  "   autocmd!
  "   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  "   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  " augroup END

" General mappings {{{
  let mapleader=","

  " disable man page for word under cursor
  nnoremap K <nop>

  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Bad behaviours
  xnoremap u <Nop>

  " Copy buffer path in clipboard
  nnoremap cp :let @+=expand('%')<CR>
  nnoremap cap :let @+=expand('%:p')<CR>

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

  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk

  " easier navigation between split windows
  nnoremap <C-J> <C-W>j
  nnoremap <C-K> <C-W>k
  nnoremap <C-H> <C-W>h
  nnoremap <C-L> <C-W>l


  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv
" }}}

" Commands and functions {{{
  " Convert hashrockets into new 1.9 hash syntax
  command! ConvertRubyHash :normal :%s/:\(\w\+\)\s*=>/\1:/ge<CR><C-O><CR>

  " remove whitespaces and windows EOL
  command! KillWhitespace :normal :%s/\s\+$//e<CR><C-O><CR>
  command! KillControlM :normal :%s/<C-V><C-M>//e<CR><C-O><CR>
" }}}

" Plugins Configuration {{{
    let g:goldenview__enable_default_mapping = 0

  " Ack {{{
    " easy global search
    " need to write `stty -ixon` in your bashrc
    " nnoremap <Leader>a <Esc>:Ag<space>
    nnoremap <C-S> :Ack <C-R><C-W><CR>
    vnoremap <C-S> y<Esc>:Ack '<C-R>"'<CR>
    " let g:ackprg = 'ag --nogroup --nocolor --column'
    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif
  " }}}

  " Fzf {{{
    let g:fzf_layout = { 'down': '~30%' }
    nmap ; :Buffers<CR>
    nmap <Leader>f :Files<CR>
    nmap <Leader>r :Tags<CR>
  " }}}

  " Vim-Test {{{
    nmap <silent> <leader>t :TestNearest<CR>
    nmap <silent> <leader>T :TestFile<CR>
    nmap <silent> <leader>a :TestSuite<CR>
    nmap <silent> <leader>l :TestLast<CR>
    nmap <silent> <leader>g :TestVisit<CR>
    let g:test#preserve_screen = 0
    let g:test#strategy = "vimux"
  " }}}

  " Yankstack {{{
    nmap <C-p> <Plug>yankstack_substitute_older_paste
    nmap <C-n> <Plug>yankstack_substitute_newer_paste
    let g:yankstack_map_keys = 0
  " }}}

  " NERDtree {{{
    map <Leader>n :NERDTreeToggle<CR>
    let g:NERDTreeMouseMode = 3
    let g:NERDTreeHighlightCursorline = 0
  " }}}

  " airline {{{
    let g:airline_left_sep='›'
    let g:airline_right_sep='‹'
    let g:airline_powerline_fonts = 0
  " }}}

  " indent guides {{{
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
  " }}}

  " neovim compatibility
    let g:indent_guides_auto_colors = 0
    hi IndentGuidesOdd  guibg=red   ctermbg=3
    hi IndentGuidesEven guibg=green ctermbg=4
  " }}}

  " ale
    let g:airline#extensions#ale#enabled = 1
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0
    let g:used_javascript_libs = 'vuejs'
    let g:ale_ruby_rubocop_executable = 'bundle'
  " }}}

  " tpope-vimragtag
    inoremap <M-o>       <Esc>o
    inoremap <C-j>       <Down>
    let g:ragtag_global_maps = 1
  " }}}

  " dash
    nmap <silent> <leader>d <Plug>DashSearch
  " }}}

" }}}


command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview({ 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all' }, 'up:60%')
  \                         : fzf#vim#with_preview({ 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all' }, 'right:50%:hidden', '?'),
  \                 <bang>0)

" vim: foldmarker={{{,}}} foldlevel=0 foldmethod=marker
