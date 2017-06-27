# Dotfiles Bankrupcy Project 

![screenshots](https://raw.githubusercontent.com/openist/dotfiles/master/putty/dotfiles.png)

Dotfiles organized using Ansible and GNU stow, based on the work of mbullington.

The font is SourceCodePro for Powerline The color scheme is based off Base16. My preferred terminal is Kitty, in the putty directory you will find .reg files that will create a session with the color scheme in either putty or kitty.

To install run these commands:

```
sudo apt-get -y install ansible
git clone https://github.com/openist/dotfiles.git ~/.dotfiles
chmod +x ~/.dotfiles/playbooks/launch
~/.dotfiles/playbooks/launch
```

Close the session then log back in.

_This is not ready for public use._
