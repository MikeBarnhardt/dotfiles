# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Use `~` as a git work tree
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Always use colored output with `ls`
alias ls="ls -G"

# List files in long format
alias la="ls -FGahl"

# Retry the previous command with `sudo` privilege
alias fucking='sudo $(history -p !!)'

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
