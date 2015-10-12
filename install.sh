#!/bin/bash

VIM_DIR="$HOME/.vim"
VUNDLE_DIR="${VIM_DIR}/bundle/Vundle.vim"
VIMRC_PATH="${HOME}/.vimrc"

if [ ! -d "$VUNDLE_DIR" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
fi

if [[ -f "$VIMRC_PATH" ]]; then
  echo "${VIMRC_PATH} already exists. Abort."
else
  ln -s "${VIM_DIR}/vimrc" "$VIMRC_PATH"
  echo "Open vim and run :PluginInstall"
fi
