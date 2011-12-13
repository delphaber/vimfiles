" Inhibit MacVim default shortcuts starting with Command and Option
let macvim_skip_cmd_opt_movement = 1

" Don't beep
set visualbell

" Start without the toolbar
set guioptions-=T

" Command-][ to increase/decrease indentation
vmap <D-]> >gv
vmap <D-[> <gv

" Fullscreen takes up entire screen
set fuoptions=maxhorz,maxvert

" Command-T for CommandT
macmenu &File.New\ Tab key=<D-T>
map <D-t> :CommandT<CR>
imap <D-t> <Esc>:CommandT<CR>

" Command-Shift-F for Ack
map <D-F> :Ack<space>

" Move between buffers with Command+Arrows
map <D-Right> :bn!<CR>
map <D-Left> :bp!<CR>

" Move to last buffer
map <D-Bslash> :b#<CR>

" Bigger fonts, please
set gfn=Monaco:h13

" Color Picker shortcut
map <D-C> :ChooseColor<CR>
imap <D-C> <Esc>:ChooseColor<CR>

" Command-Shift-R for greplace
map <D-R> :Gqfopen<CR>:ccl<CR>

" Indent guides
let g:indent_guides_guide_size=1
let g:indent_guides_color_change_percent=4
:IndentGuidesEnable
