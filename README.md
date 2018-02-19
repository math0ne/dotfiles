# Personal dotfiles orchestrated with GNU Stow and Ansible

![screenshots](https://raw.githubusercontent.com/openist/dotfiles/master/putty/dotfiles-wide.png)

Dotfiles organized using Ansible and GNU stow with a healthy splash of Docker. The font is SourceCodePro Nerd Font. The color scheme is based off Base16.

Provided Roles:

* bin - fun binary command line games utilities and screensavers
* core - git and stow
* emacs - spacemacs configuration and custom theme with integrated nerd font powered features
* htop - custom theme
* irssi - custom theme and setup
* ranger - custom theme
* tmux - tmux-next installation with custom theme and nerd font integration
* zsh - zsh terminal powered by the powerlevel9k framework with custom theme, awesome aliases, and prompt featuring nerd font symbols throughout
* docker - installation and helper utilies and application library

Features:

* unified color themes through applications
* nerd font symbols everywhere
* configuration symlinks powered by gnu stow
* included putty / mintty configurations

Upcoming roles:

* node.js - development enviroment install
* ruby - development enviroment install
* ircserver - bitlbee powered local bnc setup

Upcoming features:

* icdiff install
* secret management
* emacs org directory syncing

Currently Supported Operating Systems:

* Ubuntu 16

# Installation Instructions

> Must be run as a non root user, if necessary create and add a user

> Edit playbooks/main.yml and playbooks_galaxy/main.yml and comment out or remove any roles that you don't want to install

**1. Install ansible**
```
sudo apt-get -y install ansible
```
**2. Clone the project**
```
git clone https://github.com/math0ne/dotfiles.git ~/.dotfiles
```
**3. Install the galaxy powered roles**
```
ansible-galaxy install --roles-path=~/.dotfiles/playbooks_galaxy/roles -r ~/.dotfiles/playbooks_galaxy/requirements.yml
ansible-playbook -i ~/.dotfiles/.inventory -K ~/.dotfiles/playbooks_galaxy/main.yml -e "localuser=$USER"
```
**4. Install the main project**
```
ansible-playbook -i ~/.dotfiles/.inventory -K ~/.dotfiles/playbooks/main.yml --e "localuser=$USER"
```
**5. Close the ssh session and log back in**

# Credits

This config was inspired / built upon the work of:

* mbullington: https://github.com/mbullington
* xero: https://github.com/xero
* PhilipDaniels: https://github.com/PhilipDaniels
* ekaschalk: https://github.com/ekaschalk
* syl20bnr: https://github.com/syl20bnr
* bhilburn: https://github.com/bhilburn
* jimeh: https://github.com/jimeh
* Falkor: https://github.com/Falkor
* chriskempson: https://github.com/chriskempson
