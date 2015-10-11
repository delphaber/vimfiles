My vim configuration
==========================

Thanks to [stefanoverna](https://github.com/stefanoverna) and [Arkham](https://github.com/Arkham)

## Installation:

Prerequisites: `ruby`, `git`

1. Move your existing configuration somewhere else:
   `mv .vim* .gvim* my_backup`
2. Clone this repo into `.vim`:
   `git clone https://github.com/delphaber/vimfiles ~/.vim`
3. Go into `.vim` and run `rake`:
   `cd ~/.vim && rake`

This will install `~/.vimrc` and `~/.gvimrc` symlinks that point to
files inside the `.vim` directory.
