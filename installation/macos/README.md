# macos

MacOS dotfiles
Environment installation and configuration.
Unless stated otherwise installations are done via terminal.

## Mac Setup

These instruction must be added manually before using the makefile

### xcode

[xcode](https://developer.apple.com/xcode/) is Apple integrated development environment, if not present almost all
following instructions will fail.
Required for git.

```shell
xcode-select --install
```

### brew

- [Homebrew](https://brew.sh/) is Apple missing package manager, is my preferred method to maintain packages.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Installing git through brew allows for better control.

### git

```shell
git --version
brew install git
```

- [Rosetta](https://developer.apple.com/documentation/apple-silicon/about-the-rosetta-translation-environment) is the
  translator to Apple silicon

### Rosetta

```shell
softwareupdate --install-rosetta
```

## Personal setup

Most instructions should be also present in [makefile](makefile)

### Mac defaults

Settings for macos defaults can be found in [macos-defaults.sh](macos-defaults.sh)

### Nvim

Initiate git submodule with [nvim configuration](neovim/.config/nvim)

```shell
git submodule update --init "$HOME/anvil/neovim"

```

### Stow

Symlink configurations like nvim, ranger and zsh to the proper folders

Zsh should already be installed, but more complete installation setup can be found in [01-zsh.sh](01-zsh.sh).

```shell
stow -v -d $HOME/anvil -t ~/ macos
stow -v -d $HOME/anvil -t ~/ terminal
stow -v -d $HOME/anvil -t ~/ neovim
```

Ranger requires initialization of submodules

```shell
git submodule update --init "$HOME/anvil/terminal/.config/ranger/plugins/ranger-devicons2/"

```

### Brew

Set up all required application through brew

```shell
brew bundle
```

Packages required for my personal setup can be found in the [brewfile](Brewfile) and can be run using the following command

```shell
brew bundle --file "$HOME/anvil/installation/macos/Brewfile""
```

### Sdkman

Used for installing java, kotlin, groovy, gradle, scala and maven. Instructions can be found in [02-sdkamn.zsh](legacy/02-sdkman.zsh)
