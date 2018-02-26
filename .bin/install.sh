#!/usr/bin/env bash

# Prompt for admin password
sudo -v;

brew bundle --file=$HOME/.archive/Brewfile;
brew cleanup;
brew cask cleanup;

# Link our iTerm preferences.
rm -rf ~/Library/Preferences/com.googlecode.iterm2.plist
ln -s com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

source ~/.bash_profile;
