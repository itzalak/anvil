# Anvil

Personal laboratory mostly for development.

WIP: Ongoing refactorings
TODO: outdated, must be refactored

## Installation

- Arch Linux [installation](/installation/linux/README.md).
- MacOS [installation](/installation/macos/README.md)

### Requirements

- go-task
- python
- stow
- zsh

## Awesomewm

Take look into [awesome readme](/awesome/.config/awesome/README.md)

## Configuration

### Color scheme

This setup is designed for integrating setting up the colorscheme for linux system, and it is heavily dependent on
the `.Xresources` file.

More information and details can be found in [decorator](/terminal/.config/decorator), scripts can be
found for using a json color scheme file - I personally use [terminal.sexy](https://terminal.sexy/) to manipulate
and tweak the color schemes, porting the result for `.Xresources` and any other required formats.

It also works for macOS through `.Xresources` file, it configures mostly the terminals in that case.

**WARN** the script does not fully account for macOS usage.

- Currently using [the scream](https://github.com/itzalak/thescream.nvim)

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
git clone git@github.com:itzalak/anvil.git foundry/anvil
```

## Minimal setup

Run minimal linux installation setup manually

```shell
./foundry/anvil/installation/linux/minimal-setup.sh
```

or

```shell
curl -fsSL https://raw.githubusercontent.com/itzalak/anvil/refs/heads/main/installation/linux/minimal-setup.sh | bash
```

## Task

```shell
task: linux:awesome
task: linux:gnome
task: linux:qtile
```

Setup foundry

```shell
task: foundry:setup
```

## Other environments

For adding a new desktop create a new user and assign to wheel group. Don't forget to add the sudo config file
in the `sudoers.d` directory.

```shell
useradd -m -G wheel -s /bin/bash {{user}}
sudo passwd {{user}}
```
