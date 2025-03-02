# Anvil

Personal laboratory mostly for development.

WIP: Ongoing refactorings
TODO: outdated, must be refactored

## Installation

// TODO:

### Requirements

- go-task
- python
- stow
- zsh

## Configuration

### Zsh

<!--WIP: needs to be refactored-->

Configuration for zsh can be found under [zsh folder](./zsh/) plus [arch folder](./arch) or [macos folder](./macos), specific os folders are required for correct functioning of the system like brew - and can it can be setup by allocating the files to the proper directory using [stow](https://www.gnu.org/software/stow/), symlink or just copying them.
There are three sets of stow folders to configure, they can be found under [base](terminal/), [zsh](./zsh/) and specific to OS (plus neovim).

Zsh framework configuration uses a self-installed, self-managed plugin manager called [zimfw](https://github.com/zimfw/zimfw) that will install itself and setup all needed plugins once zsh is started.
Plugin configuration can be found in the [.zimrc file](terminal/.config/zsh/.zimrc).
A folder will automatically be created as `.zim` to store all required files for `zimfw`.

Global variable `ZDOTDIR` is defined under `./zshenv` as `$HOME/.config/zsh`. This tells zsh to look for further configurations files in that directory.
In `./zshrc` we load all configuration files within the `ZDOTDIR` directory ending in `*.zsh`. This is not required but it facilitates managing special configurations and settings.

<details>
<summary>Structure</summary>
<br>

```shell
.
├── .config
│   └── zsh
│       ├── ...
│       ├── 04-history.zsh
│       ├── 05-git.zsh
│       ├── 10-environment.zsh
│       ├── ...
│       ├── 99-end.zsh
│       ├── .zimrc
│       └── .zshrc
└── .zshenv
```

</details>

## Anvil setup

Clone the anvil repository

```shell
mkdir -p foundry
git clone git@github.com:itzalak/anvil.git anvil
```

## Minimal setup

Run minimal linux installation setup manually

```shell
./foundry/anvil/taskfiles/scripts/00-cachy-minimal.sh
```

or

```shell
curl -fsSL https://raw.githubusercontent.com/itzalak/anvil/refs/heads/main/taskfiles/scripts/00-cachy-minimal.sh | bash
```

## Task

// TODO:

## Other environments

For adding a new desktop create a new user and assign to wheel group. Don't forget to add the sudo config file
in the `sudoers.d` directory.

```shell
useradd -m -G wheel -s /bin/bash {{user}}
sudo passwd {{user}}
```
