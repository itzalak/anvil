# Refactoring - shogun

<!-- TOC -->
- [Refactoring - shogun](#refactoring---shogun)
    - [TODO](#todo)
    - [Structure](#structure)
    - [Installer](#installer)
    - [Repositories](#repositories)
    - [References](#references)
<!-- TOC -->

## TODO

- [ ] Revisit installer scripts
    - [ ] Needs to be run with the basic tools present on a brand new installation
    - [ ] Installation probably should be split on complete tasks by tool...
        - [ ] How to handle stow?
    - [x] pacman/brew with a minimal script run from curl
    - [x] ~~What about the git configuration~~
- [ ] Reconsider breaking macos to its own repository
    - macos has limitations because of the ssh setup (prevent personal commits with company email)
        - os specific configurations are growing
- [ ] Backup script
- [ ] Consider gum use cases to simplify configurations
- [ ] Create a scratch shell with a file with a WIP note
    - [ ] Maybe even encrypted
- [ ] Revisit ranger image preview for macos and wezterm.
- [ ] Consider what to do against duplication of the brewfile and tasks
- [ ] Move the decorator to root? To consider?

## Structure

```shell
anvil
├── .git
├── .github
│  └──  workflows
├── anvil
├── awesome
│  ├── .config
│  └── .local
├── bin
├── docs
├── installation
│  ├── linux
│  └── macos
├── linux
│  └── qtile
├── macos
│  ├── .config
│  └── .local
├── neovim
│  └── .config
├── qtile
│  ├── .config
│  └── .local
├── terminal
│  └── .config
└── wallpapers
```

## Installer

> **WIP**
> Using stow there are 2 different behaviors to consider.
> Packages like neovim need to be fully symlinked, for zsh folder creation is required
> Also, files like installation scripts and makefile are not to be stowed

Objective:

- Install via scripts per os (done by task)
    - Single script is not very helpful in case of failures, step by step might be better (maybe with input?)
    - Brew installation might need to be a script, for installing brew and installing the brewfile
- Create a backup upon request
- Command for any action available everywhere (from bin)

The installation should be completed by running something akin to the following line

## Repositories

New structure, already applied.

```shell
foundry
├── anvil
├── ...
├── depository
├── forge
└── scratchpad
```

> Considering the limitations of the professional setup I need to rethink the structure
> All repositories must be under directories personal and work
> ...
> Maybe it's time to split macos from linux

## IDEA

WIP: can I script this? or change? also update...
Or move to notes?

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

## References

- [yas-bdsm](https://github.com/sebastiancarlos/yas-bdsm)
- [radm](https://github.com/robertarles/radm)
- [dotdrop](https://github.com/deadc0de6/dotdrop)