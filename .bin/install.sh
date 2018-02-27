#!/usr/bin/env bash

# Install Xcode CLI
xcode-select --install

# Clone dotfiles into a bare hidden repository.
git clone --bare https://github.com/MikeBarnhardt/dotfiles.git $HOME/.dotfiles

# Manually set up a git alias.
function dot {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# Remove any conflicting files.
dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs rm -rf

# Install Homebrew if not already installed
if ! which brew > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

# Install using $HOME/.Brewfile
brew bundle --global;

# Remove installation files afterwards.
brew cleanup;
brew cask cleanup;

# Link our iTerm preferences.
rm -rf ~/Library/Preferences/com.googlecode.iterm2.plist
ln -s $HOME/.archive/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
