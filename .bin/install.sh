#!/usr/bin/env bash

git pull origin master;

brew bundle;
brew cleanup;
brew cask cleanup;

# Copy files from current directory to `~`
rsync --exclude ".git/" \
      --exclude ".DS_Store" \
      --exclude ".macos" \
      --exclude "com.googlecode.iterm2.plist" \
      --exclude "install.sh" \
      --exclude "Monokai Soda.itermcolors" \
      --exclude "README.md" \
      -avh --no-perms . ~;

# Link our iTerm preferences.
# ln -s com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

source ~/.bash_profile;
