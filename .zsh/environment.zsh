# Add `~/bin` to `$PATH`
export PATH=$PATH:$HOME/bin

# Homebrew recommends adding `/usr/local/sbin` to `$PATH`
export PATH=/usr/local/sbin:$PATH

# Shim `nodenv` paths
eval "$(nodenv init -)";
