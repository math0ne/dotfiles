# Personal dotfiles orchestrated with GNU Stow and Ansible

![screenshots](https://raw.githubusercontent.com/openist/dotfiles/master/putty/dotfiles-wide.png)

Dotfiles organized using Ansible and GNU stow with a good splash of Docker.

The font is SourceCodePro for Powerline. The color scheme is based off Base16. My preferred terminal is MinTTY or Kitty, in the putty/mintty directory you will find files to configure your terminal of choice.

Includes configurations for:

* tmux
* spacemacs
* zsh
* ranger
* irssi
* docker

Currently Supported Operating Systems:

* Ubuntu 16

# Installation Instructions

### 1. If necessary create a user, this cannot be run as root:
```
adduser math0ne
usermod -aG sudo math0ne
```
### 2. Login as the new user
### 3. Edit playbooks/ubuntu.yml to correspond to the new user account.
### 4. Run these commands:
```
sudo apt-get -y install ansible
git clone https://github.com/math0ne/dotfiles.git ~/.dotfiles
chmod +x ~/.dotfiles/playbooks/launch
~/.dotfiles/playbooks/launch
```
### 5. Close the session then log back in.

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
