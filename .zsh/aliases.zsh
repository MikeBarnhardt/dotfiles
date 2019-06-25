# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Use `~` as a git work tree
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Always use colored output with `ls`
alias ls="ls -G"

# List all files
alias la="ls -1Fa"

# Directory traversal
alias ..="cd .."

# Allow sudo to be used in aliases
alias sudo="sudo "

# Retry the previous command with `sudo` privilege
alias fucking='sudo $(history -p !!)'
alias please='sudo $(history -p !!)'

# Move windows
alias move-atom="osascript -e 'tell application \"System Events\" to tell process \"Atom\"' -e 'set position of window 1 to {918, 64}' -e 'set size of window 1 to {1578, 1312}' -e 'end tell'" 

alias move-cal="osascript -e 'tell application \"System Events\" to tell process \"Calendar\"' -e 'set position of window 1 to {918, 64}' -e 'set size of window 1 to {1578, 1312}' -e 'end tell'" 

alias move-iterm="osascript -e 'tell application \"System Events\" to tell process \"iTerm2\"' -e 'set position of window 1 to {1312, 64}' -e 'set size of window 1 to {1184, 1312}' -e 'end tell'" 

alias move-notes="osascript -e 'tell application \"System Events\" to tell process \"Notes\"' -e 'set position of window 1 to {640, 360}' -e 'set size of window 1 to {1280, 720}' -e 'end tell'" 

alias move-safari="osascript -e 'tell application \"System Events\" to tell process \"Safari\"' -e 'set position of window 1 to {918, 64}' -e 'set size of window 1 to {1578, 1312}' -e 'end tell'" 

# Soon to be deprecated
alias move-chrome="osascript -e 'tell application \"System Events\" to tell process \"Google Chrome\"' -e 'set position of window 2 to {918, 64}' -e 'set size of window 2 to {1578, 1312}' -e 'end tell'" 
