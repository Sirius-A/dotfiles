# Dotfiles

> *Guess I'm joining the club as well* ¯\\\_(ツ)_/¯

## Usage

This project follows the approach of using a [`bare git repo`](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/)
to manage all config files. No symlinks or copying of files required. Another benefit of a bare repo is that it does not create a `.git` folder and therefore does not interfere with any other git projects in the home directory. More info can be found in this [Atlassian blog post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

A Git alias (`config`) is used to manage all configuration files from the
`$HOME` directory. By default all files which were not explicitly added are not
shown in the `config status`.

[Ansible](https://www.ansible.com) is used to install the required Software in a modular way.

### Install / Setup

``` sh
git clone --bare git@github.com:Sirius-A/dotfiles.git ~/.cfg

# Initial config alias setup
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no

# Setup the configuration files from this repo
config checkout

# Install all the required software for your usecase (remove unneeded tags)
cd dotfiles-ansible
ansible-playbook -i hosts dotfiles.yml --ask-become-pass --tags=shell,vim,desktop

# Install tmux plugins
tmux
<prefix> + I # (Captial I)

```

### Update / Add Configs

Updates are done through the `config` alias. (Just like any git project)

``` sh
config add -p
config commit -m "update"
config push
```

## Additional Configs
- VSCode settings and extensions are managed in a [separate gist](https://gist.github.com/Sirius-A/302a99c5840e6b462c2bad27ee1880d3) using the [Settings Sync Extension](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync).
- Theme for WSLtty / Mintty: https://github.com/arcticicestudio/nord-mintty
