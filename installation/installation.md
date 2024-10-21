# Installation

WIP: should be something like a bash script. probably?

Clone the anvil repository

```shell
mkdir -p foundry
git clone git@github.com:itzalak/anvil.git foundry/anvil
```

## Linux

Run minimal linux installation setup

```shell
./foundry/anvil/installation/linux/minimal-setup.sh
```

TODO: update when in master

```shell
curl -fsSL https://raw.githubusercontent.com/itzalak/anvil/refs/heads/v7-shogun/installation/linux/minimal-setup.sh | bash
```

## Macos

Run minimal macos installation setup

```shell
./foundry/anvil/installation/macos/minimal-setup.sh
```

TODO: update when in master

```shell
curl -fsSL https://raw.githubusercontent.com/itzalak/anvil/refs/heads/v7-shogun/installation/macos/minimal-setup.sh | bash
```

## Task

```shell
task: linux:setup-awesome
task: linux:setup-gnome
task: linux:setup-qtile
task: macos:setup
```

Setup foundry

```shell
task: foundry:setup
```
