#!/bin/bash

# To maintain cask ....
# brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`

# Install native apps

# productivity
brew cask install 1password
brew cask install google-chrome

# dev
brew cask install kitty
brew cask install visual-studio-code

# design
brew cask install figma

# communication
brew cask install slack
brew cask install discord

# fonts
brew tap homebrew/cask-fonts
brew cask install font-hack
brew cask install font-open-sans
brew cask install font-roboto
