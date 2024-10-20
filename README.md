# Anvil

Personal laboratory mostly for development.

WIP: Ongoing refactoring!

## Installation

- Install Arch Linux using [archinstall v2.5.2](https://github.com/archlinux/archinstall/tree/v2.5.2).
- MacOS installed via [brew](installation/macos/Brewfile)

Clone the anvil repository.

```shell
git clone https://github.com/itzalak/anvil.git
```

- Instructions for archlinux in [makefile](installation/linux/makefile).
- Instructions for macOS in [makefile](installation/macos/makefile) and [readme](installation/macos/README.md).

## Requirements

- task (go-task for linux)
- python
- stow
- zsh

WIP: look into the taskfiles

## Awesomewm

Take look into [awesome readme](/awesome/.config/awesome/README.md)

## Configuration

### Color scheme

This setup is designed for integrating setting up the colorscheme for linux system and it is heavily dependent on
the `.Xresources` file, including `awesomewm`.

More information and details can be found in [decorator](terminal/.config/decorator), inside scripts can be
found for using a json color scheme file - I personally use [terminal.sexy](https://terminal.sexy/) - and
porting the result for `.Xresources` and other required formats.

It also works for macOS through `.Xresources` file, it configures mostly the terminals in that case, **WARN** the script
does not account for macOS usage.

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
│       ├── 00-path.zsh
│       ├── 02-aliases.zsh
│       ├── 04-history.zsh
│       ├── 05-git.zsh
│       ├── ..
│       ├── 99-starship.zsh
│       ├── .zimrc
│       └── .zshrc
└── .zshenv
```

</details>

## Gnome

For using a full gnome desktop create a new user and assign to wheel group.

```shell
useradd -m -G wheel -s /bin/bash {{user}}
sudo passwd {{user}}
```

For installation follow instructions in [makefile](installation/linux/makefile) for gnome instead of awesome.

## IDEA

Intellij IDEA community useful plugins:

- .ignore
- Emmylua
- Gherkin
- GraphQL
- Hiberbee Theme
- IdeaVim
- Makefile Language
- Python
- Rainbow Brackets Lite
- Terraform and HCL

## Issues

Some issues might arise while configuring this application, initializing submodules and cloning uses ssh and for it to
work ssh must be configured with github.
