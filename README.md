# dotfiles

Config files 


## Requirements / tools used
- Neovim or (Vim8 with python support): https://github.com/neovim/neovim/wiki/Installing-Neovim
- Python3 https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
- Zsh https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH 
- A nerd font of choice: https://github.com/ryanoasis/nerd-fonts

## Usage

This project follows the approach of using a [`bare git repo`](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/)
to manage all config files. No symlinks or copying of files required. Another benefit of a bare repo is that it does not create a `.git` folder and therfore does not interfere with any other git projects in the home directory.

A Git alias `config` is used to manage all configuration files in the `$HOME` directory. By default all, which were not expicitly added are not shown in the `config status`.

### Install / Setup

``` sh
cd
git clone --bare git@github.com:Sirius-A/dotfiles.git ~/.cfg

# Initial config alias setup
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no

# Setup the configuration files form this repo
config checkout   
```

### Update / add configs

Updates are done through the `config` alias. (Just like any git project)

``` sh
config add -p
config commit -m "update"
config push
```

## Additional configs

* VSCode settings and extensions are managed in a [separate gist](https://gist.github.com/Sirius-A/302a99c5840e6b462c2bad27ee1880d3) using the [Settings Sync Extension](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync). 
