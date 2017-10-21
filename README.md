My vim configuration
==========================

Thanks to [stefanoverna](https://github.com/stefanoverna) and [Arkham](https://github.com/Arkham)

## Installation:

Prerequisites: `vim` (7.4+), `git`

1. Move your existing configuration somewhere else:
   `mv .vim* .gvim* my_backup`

2. Clone this repo into `.vim`:

   `git clone https://github.com/delphaber/vimfiles ~/.vim`

3. Go into `.vim` and run `install.sh`:

   `cd ~/.vim && bash install.sh`

   This will install `~/.vimrc` symlinks that point to
   files inside the `.vim` directory.

4. Open vim (ignore error on missing color scheme), and run `:PluginInstall`.

5. On install complete, quit vim and open it again.

6. Profit!

7. If you want to use neovim, follow install instruction and read [this](https://neovim.io/doc/user/nvim.html#nvim-from-vim)
