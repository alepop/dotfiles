#!/bin/bash

DOTFILE_DIR=$HOME/.dotfiles

DOTFILES=(
	"git"
  "nvim"
  "fish"
  "kitty"
  "starship"
)

for dotfile in "${DOTFILES[@]}";do
	echo "🔗 Linking dotfile: $HOME/.${dotfile}"
	stow $dotfile
done
