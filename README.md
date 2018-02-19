# Dotfiles organized using Ansible and GNU stow with a healthy splash of Docker.

![screenshots](https://raw.githubusercontent.com/openist/dotfiles/master/putty/dotfiles-wide.png)

My config is based on Ansible roles that can be enabled or disabled based on the needs at hand.  The roles contain application installation scripts and configuration data. The current included roles are:
* **core** - git and stow
* **emacs** - spacemacs configuration and custom theme with integrated nerd font powered features
* **htop** - custom theme
* **irssi** - custom theme and setup
* **ranger** - custom theme
* **tmux** - tmux-next installation with custom theme and nerd font integration
* **zsh** - zsh terminal powered by the powerlevel9k framework with custom theme, awesome aliases, and prompt featuring nerd font symbols throughout
* **bin** - fun binary command line games utilities and screensavers
* **docker** - installation and helper utilies and application library
* **node.js** - node development enviroment
* **ruby** - ruby development setup and global bundler install

The configuration trys to provide common features through the supported roles:
* unified color themes through applications using base16 variation
* nerd font symbols everywhere
* configuration symlinks powered by gnu stow
* included putty / mintty configurations

Currently Supported Operating Systems:
* Ubuntu 16

# Installation Instructions

> Must be run as a non root user, if necessary create and add a user

**1. Install ansible**
```
sudo apt-get -y install ansible
```
**2. Clone the project**
```
git clone https://github.com/math0ne/dotfiles.git ~/.dotfiles
```

> Now you can disable any of the main roles you don't need by commenting them out in the `.dotfiles/playbooks/main.yml` file, eg:

```yaml
  roles:
    - core
    # - tmux
    - emacs
```

> Additional Ansible Galaxy roles have to be added or removed from both the `.dotfiles/playbooks/main.yml` file:

```yaml
  roles:
    # - nickjj.docker
    - your.role
```

> And the `.dotfiles/playbooks/requirements.yml` file:

```yaml
# - src: nickjj.docker
- src: your.role
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

# TODO

**Upcoming roles:**
* node.js - development enviroment install
* ruby - development enviroment install
* ircserver - bitlbee powered local bnc setup

**Upcoming features:**
* icdiff install
* secret management
* emacs org directory syncing
