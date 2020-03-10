#!/bin/bash

###########################
# This script installs the dotfiles and runs macOS configurations
# @author Helder Burato Berto
###########################

echo "🔧 Setting up your Mac..."

# Set macOS preferences
sh ./mac/.macos

# Install non-brew various tools (PRE-BREW Installs)
echo "Ensuring build/install tools are available"
if ! xcode-select --print-path &> /dev/null; then
    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? ' XCode Command Line Tools Installed'

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "📲 Installing homebrew/app store packages..."
sh ./homebrew/brew.sh
echo "✅ Successful installed packages"

echo "📁 Creating workspaces directories..."
sh ./mac/tasks/create_workspace.sh
echo "✅ Successful created workspaces"

echo "🔗 Linking configuration files..."
sh ./mac/tasks/symlink.sh
echo "✅ Successful linked configuration files"

echo "📲 Installing minpac for nvim..."
git clone https://github.com/k-takata/minpac.git \
    ~/.config/nvim/pack/minpac/opt/minpac
echo "✅ Minpac successful installed "

echo "🖥 Setting fish as default shell.."
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
echo "✅ Successfuly set fish as default shell"

# Add default apps to Dock
echo "🖥 Setting apps to Mac dock..."
sh ./mac/setup_dock.sh
echo "✅ Successful set apps to Mac dock"

echo "⚡️ All right! Restart your machine to complete the configuration."
