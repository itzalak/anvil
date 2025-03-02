# Refactoring - shogun

<!-- TOC -->
- [Refactoring - shogun](#refactoring---shogun)
    - [TODO](#todo)
    - [IDEA](#idea)
<!-- TOC -->

## TODO

- [ ] Revisit installer scripts
    - [ ] Needs to be run with the basic tools present on a brand new installation
    - [ ] Installation probably should be split on complete tasks by tool...
        - [ ] How to handle stow?
- [ ] Reconsider breaking macos to its own repository
    - macos has limitations because of the ssh setup (prevent personal commits with company email)
        - os specific configurations are growing
- [ ] Backup script
- [ ] Consider gum use cases to simplify configurations
- [ ] Create a scratch shell with a file with a WIP note
    - [ ] Maybe even encrypted
- [ ] Consider what to do against duplication of the brewfile and tasks
- [ ] Move the decorator to root? to its own package? reconsider

- make linux installation more manageable, it is to big with too many failure points
- Add tlp to installation <https://linrunner.de/tlp/installation/arch.html>
- Considerations on installation of the LTS version for arch
- consider backup tools
    - <https://github.com/linuxmint/timeshift> - system backup
    - <https://github.com/linuxmint/mintbackup> - user data backup

- [ ] Export keybindings: <https://askubuntu.com/questions/26056/where-are-gnome-keyboard-shortcuts-stored>
- [ ] Consider looking into gamemode: <https://wiki.archlinux.org/title/Gamemode>
- [ ] Explore remapping with <https://github.com/rvaiya/keyd>

Starting from a blank slate gives me a few questions and opportunities, first and foremost, un-bloat the installation,
second split by need and requirements.

## Relevant documentation

- <https://github.com/archlinux/archinstall>
- <https://wiki.archlinux.org/title/Installation_guide>
- <https://wiki.archlinux.org/title/Laptop>
- <https://wiki.archlinux.org/title/Laptop/ASUS>
- <https://dlcdnets.asus.com/pub/ASUS/GamingNB/GA403UV/0407_G23090_GA403U_V2_A.pdf?model=ROG%20Zephyrus%20G14%20(2024)%20GA403>
- <https://dlcdnets.asus.com/pub/ASUS/GamingNB/GA403UV/E23090_GA403U_EM_V2.pdf?model=ROG%20Zephyrus%20G14%20(2024)%20GA403>
- <https://wiki.archlinux.org/title/ASUS_Linux>
- <https://www.reddit.com/r/ZephyrusG14/comments/1ah226s/ive_made_another_rog_control_daemon_for_linux/>

## Concerns

- Not sure  how to setup dual boot with btrfs and partitions
    - Seems resource intensive and error prone
    - Disk management can be done outside the app, and then mounted
- <https://wiki.archlinux.org/title/Partitioning#Example_layouts>
- Look into <https://gitlab.com/btrfs-assistant/btrfs-assistant>
- <https://wiki.archlinux.org/title/Snapper>

- AMD + NVIDIA
    - <https://www.youtube.com/watch?v=ceQymkVg50k>
- dGPU management
    - According to the wiki, open drivers for both apps should be enough
    - <https://wiki.archlinux.org/title/PRIME#Open-source_drivers>
    - both graphics run simultaneously but the dGPU has minimal resource consumption
    - unknown impact on steam
    - open drivers will allow me to keep using ly
    - probably don't need supergfxctl
- I am starting to think asusctl is not reasonable or valuable, optionally there is rog-daemon, still unsure
    - <https://aur.archlinux.org/packages/rog-daemon>
- Should I try EndeavourOS?
    - uses calamares
    - has default configurations already set for many apps

## Open questions

- Can I configure btrfs 'partitions' after installation?
    - For snapshots I think yes, others still unclear
- EFI size for Nvidia + dual boot
- Archinstall did not install AMD graphics, can I start with AMD and later install Nvidia? How?
- Basic setup of bash is dreadful, needs revisiting
- <https://sharafat.pages.dev/archlinux-install/>

## IDEA

Configuration as  code for pycharm and IDEA

Intellij IDEA community useful plugins:

- .ignore
- Emmylua
- Gherkin
- GraphQL
- IdeaVim
- Makefile Language
- Python
- Rainbow Brackets Lite
- Terraform and HCL
