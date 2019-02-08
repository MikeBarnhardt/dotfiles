# Add `~/bin` to `$PATH`
export PATH=$PATH:$HOME/bin

# Use Vim as the preferred editor
# export EDITOR=vim
# export VISUAL=vim

# Use 256 color terminals
# export TERM=xterm-256color

# Use English as preferred language
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LESSCHARSET=utf-8

# Shim `nodenv` NodeJS paths
eval "$(nodenv init -)";
