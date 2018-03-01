#!/usr/bin/env bash

source ~/.bin/echoes.sh

########################################################################
# Install Xcode Command Line Tools                                     #
########################################################################

info "Installing Xcode Command Line Tools"
if ! xcode-select -p &> /dev/null; then
  xcode-select --install &> /dev/null
  wait

  # Prompt to accept Xcode license agreement.
  info "Agree to the terms of the Xcode license?"
  sudo xcodebuild -license accept &> /dev/null
  wait
else
  ok "Xcode Command Line Tools already installed!"
fi

########################################################################
# Setup dotfiles repository                                            #
########################################################################

# A shortcut replacement for `git` that will use our home directory as
# a working git directory, but git files are stored in the .dotfiles
# folder. This is also set as an alias in `.aliases` to edit/update
# later.
function dot {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

info "Setting up dotfiles"
if which git &> /dev/null; then
  if [[ ! -d $HOME/.dotfiles ]]; then
    # Set up a `--bare` repository. This results in a directory that
    # functions like a `.git` folder. This way we can keep our files
    # directly in `$HOME`.
    info "Fetching the dotfiles repository."
    git clone --bare https://github.com/MikeBarnhardt/dotfiles.git $HOME/.dotfiles
    wait

    # Checkout and replace any conflicting files.
    info "Copying dotfiles from repository to home folder"
    dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs rm -rf
    wait

    # Don't show untracked files. Since `$HOME` is our working directory
    # we only want to manually add files to track.
    #
    # Do not use `dot add .` or `dot commit -a` under any circumstances.
    dot config status.showUntrackedFiles no
  else
    error "$HOME/.dotfiles already exists. Refusing to clone repository."
  fi
else
  error "Can't fetch repository: `git` is not installed."
fi

########################################################################
# Install Homebrew                                                     #
########################################################################

# Test if Homebrew is already installed; if not, install it.
info "Installing Homebrew"
# Install Homebrew if not already installed
if ! which brew > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  wait
else
  ok 'Homebrew is already installed.'
fi;

# Using a global Brewfile (located in the users's home directory) we
# automatically install all our programs.
info "Installing from Brewfile"
if [ -f $HOME/.Brewfile ]; then
  brew bundle --global
  wait
else
  error "$HOME/.Brewfile does not exist."
fi

# Remove installation files afterwards.
info "Cleaning up Homebrew files."
brew cleanup
brew cask cleanup
wait

# Copy our iTerm preferences.
# cp $HOME/.extra/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist 2> /dev/null

# Setup macOS defaults
# sh $HOME/.macos
