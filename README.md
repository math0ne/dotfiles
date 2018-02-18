# Personal dotfiles orchestrated with GNU Stow and Ansible

![screenshots](https://raw.githubusercontent.com/openist/dotfiles/master/putty/dotfiles-wide.png)

Dotfiles organized using Ansible and GNU stow with a good splash of Docker.

The font is SourceCodePro Nerd Font. The color scheme is based off Base16.

Features:

* unified color themes through applications
* tmux configuration and upgraded install
* spacemacs configuration
* zsh terminal powered by the powerlevel9k framework
* ranger configuration
* irssi configuration
* docker install and utilities
* nerd font symbols features in zsh and spacemacs
* configuration symlinks powered by gnu stow
* htop configuration
* git utilities and aliases
* included putty / mintty configurations

Upcoming features:

* docker powered local application directory
* node.js development enviroment install
* ruby development enviroment install
* icdiff install
* secret management
* emacs org directory syncing
* dockerized irc setup

Currently Supported Operating Systems:

* Ubuntu 16

# Installation Instructions

* _(Optional)_ Create the user
```
adduser USERNAME
```
* _(Optional)_ Allow ths user to sudo
```
usermod -aG sudo USERNAME
```
* _(Optional)_ Change to the new user
```
su USERNAME
```
* Install ansible
```
sudo apt-get -y install ansible
```
* Clone the project
```
git clone https://github.com/math0ne/dotfiles.git ~/.dotfiles
```
* Install the galaxy powered roles
```
ansible-galaxy install --roles-path=~/.dotfiles/playbooks_galaxy/roles -r ~/.dotfiles/playbooks/requirements.yml
ansible-playbook --extra_vars "localuser=$user" -i ~/.dotfiles/playbooks/inventory -K ~/.dotfiles/playbooks_galaxy/main.yml
```
* Install the main project
```
ansible-playbook --extra_vars "localuser=$user" -i ~/.dotfiles/playbooks/inventory -K ~/.dotfiles/playbooks/main.yml
```
* Close the ssh session and log back in

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
