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

# Don't show untracked files
dot config status.showUntrackedFiles no

# Install Homebrew if not already installed
if ! which brew > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

# Install using $HOME/.Brewfile
brew bundle --global;

# Remove installation files afterwards.
brew cleanup;
brew cask cleanup;

# Copy our iTerm preferences.
cp $HOME/.extra/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist 2> /dev/null

# Setup macOS defaults
sh $HOME/.macos
