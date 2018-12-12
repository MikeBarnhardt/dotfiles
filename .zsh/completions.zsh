# Add completions to `$fpath`
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit && compinit
