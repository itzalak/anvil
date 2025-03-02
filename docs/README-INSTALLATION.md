# macos

TODO: revisit

MacOS dotfiles
Environment installation and configuration.
Unless stated otherwise installations are done via terminal.

## Mac Setup

Minimal installation (automatic)

For macos

```shell
curl -fsSL https://raw.githubusercontent.com/itzalak/anvil/refs/heads/main/taskfiles/scripts/00-brew-minimal.sh | bash
```

Setup ssh and git.
Clone the anvil repository.

```shell
mkdir -p foundry
git clone git@github.com:itzalak/anvil.git
```

Follow up on [taskfile](/taskfiles/taskfile.macos.yml)

## Manual installation

### xcode

[xcode](https://developer.apple.com/xcode/) is Apple integrated development environment, if not present almost all
following instructions will fail.
Required for git.

```shell
xcode-select --install
```

### brew

NOTE: Already installed by the brew minimal curl step

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

### Rosetta

- [Rosetta](https://developer.apple.com/documentation/apple-silicon/about-the-rosetta-translation-environment) is the
  translator to Apple silicon

```shell
softwareupdate --install-rosetta
```

### Mac defaults

Settings for macos defaults can be found in [macos-defaults.sh](../taskfiles/scripts/99-macos-defaults.sh)

### Brew

Set up all required application through brew

```shell
brew bundle
```

Packages required for my personal setup can be found in the [brewfile](../taskfiles/scripts/Brewfile) and can be run using the following command
