#!/usr/bin/env bash

########################################################################
# Echoers                                                              #
########################################################################

# Display an info message
function info() {
  echo "\033[44m\033[30m INFO \033[39;49;00m \033[34m$1\033[39;49;00m"
}

# Display a success message
function ok() {
  echo "\033[42m\033[30m OKAY \033[39;49;00m \033[32m$1\033[39;49;00m"
}

# Display a warning message
function warn() {
  echo "\033[43m\033[30m WARN \033[39;49;00m \033[33m$1\033[39;49;00m"
}

# Display an error message
function error() {
  echo "\033[45m\033[30m FAIL \033[39;49;00m \033[35m$1\033[39;49;00m"
}

########################################################################
info "Installing Homebrew"
########################################################################

# Homebrew automatically installs Xcode Command Line Tools
if ! which brew > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  ok 'Homebrew is already installed.'
fi;

########################################################################
info "Setting up dotfiles"
########################################################################

# A shortcut replacement for `git` that will use our home directory as
# a working git directory, but git files are stored in the .dotfiles
# folder. This is also set as an alias in `.aliases` to edit/update
# later.
function dot {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

if which git &> /dev/null; then
  if [[ ! -d $HOME/.dotfiles ]]; then
    # Set up a `--bare` repository. This results in a directory that
    # functions like a `.git` folder. This way we can keep our files
    # directly in `$HOME`.
    info 'Cloning repository `.dotfiles`'
    git clone --bare https://github.com/MikeBarnhardt/dotfiles.git $HOME/.dotfiles

    # Checkout and replace any conflicting files.
    info 'Checking out `.dotfiles`'
    dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs rm -rf

    # Don't show untracked files. Since `$HOME` is our working directory
    # we only want to manually add files to track.
    #
    # Do not use `dot add .` or `dot commit -a` under any circumstances.
    dot config status.showUntrackedFiles no
  else
    warn 'Directory `.dotfiles` already exists'
  fi
else
  error "Can't fetch repository: `git` is not installed."
fi

########################################################################
info "Installing Homebrew Applications"
########################################################################

# Using a global Brewfile (located in the users's home directory) we
# automatically install all our programs.
if [ -f $HOME/.Brewfile ]; then
  brew bundle --global
else
  error "$HOME/.Brewfile does not exist."
fi

# Remove installation files afterwards.
brew cleanup
brew cask cleanup

# Copy our iTerm preferences.
cp $HOME/.extra/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist 2> /dev/null
