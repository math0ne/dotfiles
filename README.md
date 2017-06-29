# Personal dotfiles orchestrated with GNU Stow and Ansible

![screenshots](https://raw.githubusercontent.com/openist/dotfiles/master/putty/dotfiles-tall.png)

Dotfiles organized using Ansible and GNU stow.

The font is SourceCodePro for Powerline. The color scheme is based off Base16. My preferred terminal is Kitty, in the putty directory you will find .reg files that will create a session with the color scheme in either putty or kitty.

Includes configurations for:

* tmux
* spacemacs
* zsh
* ranger
* irssi

To install run these commands:

```
sudo apt-get -y install ansible
git clone https://github.com/openist/dotfiles.git ~/.dotfiles
chmod +x ~/.dotfiles/playbooks/launch
~/.dotfiles/playbooks/launch
```

Close the session then log back in.

This config was inspired / built upon the work of:

* mbullington: https://github.com/mbullington
* xero: https://github.com/xero
* PhilipDaniels: https://github.com/PhilipDaniels
* ekaschalk: https://github.com/ekaschalk
* syl20bnr: https://github.com/syl20bnr
* bhilburn: https://github.com/bhilburn
* jimeh: https://github.com/jimeh
* Falkor: https://github.com/Falkor
