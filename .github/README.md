# macOS Setup

Install Homebrew:

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Clone this repository:

```shell
git clone --bare https://github.com/MikeBarnhardt/dotfiles.git $HOME/.dotfiles
```

Install Homebrew applications:

```shell
brew bundle --global
```

Change shell to zsh:

```shell
chsh -s /usr/local/bin/zsh
```
