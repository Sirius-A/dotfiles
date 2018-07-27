# dotfiles

configs

## Requirements / tools used
- Neovim or (Vim8 with python support): https://github.com/neovim/neovim/wiki/Installing-Neovim
- Python3 https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
- Zsh https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH 
- A Nerd font of choice: https://github.com/ryanoasis/nerd-fonts

## Usage

This project follows the approach of using a [`bare git repo`](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/)
to manage all config files. The benefit of a bare repo it that it does not create a `.git` folder and does not interfere with any other git projects.

An git alias `config` is used to manage all configuration files in the `$HOME` directory. By default all files are untracked and ignored.

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
config add <filename>
config commit -m "update"
config push
```


