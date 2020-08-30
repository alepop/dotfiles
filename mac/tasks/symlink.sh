#!/bin/bash

DOTFILE_DIR=$HOME/.dotfiles

DOTFILES=(
  "git"
  "nvim"
  "fish"
  "starship"
  "alacritty"
)

for dotfile in "${DOTFILES[@]}";do
	echo "🔗 Linking dotfile: $HOME/.${dotfile}"
	stow $dotfile
done
