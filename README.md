# Dotfiles

> *Guess I'm joining the club as well* ¯\\\_(ツ)_/¯

## Requirements / Tools Used
- Neovim (or Vim8 with python support): https://github.com/neovim/neovim/wiki/Installing-Neovim
  - Plugin manager:  vim-plug https://github.com/junegunn/vim-plug#installation
  - Python3 support https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
- Zsh https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
  - Plugin manager: Antigen https://github.com/zsh-users/antigen#installation
- A nerd font of choice: https://github.com/ryanoasis/nerd-fonts
- Terminal Emulator for Win10 WSL: https://github.com/mintty/wsltty#installation-from-this-repository

## Usage

This project follows the approach of using a [`bare git repo`](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/)
to manage all config files. No symlinks or copying of files required. Another benefit of a bare repo is that it does not create a `.git` folder and therefore does not interfere with any other git projects in the home directory. More info can be found in this [Atlassian blog post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

A Git alias (`config`) is used to manage all configuration files from the `$HOME` directory. By default all files which were not expicitly added are not shown in the `config status`.

### Install / Setup

``` sh
git clone --bare git@github.com:Sirius-A/dotfiles.git ~/.cfg

# Initial config alias setup
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no

# Setup the configuration files form this repo
config checkout

# Install tmux plugins
tmux
<prefix> + I # (Captial I)

# Intall Vim plugins
# (Also installs fzf for the system)
nvim
:PlugInstall
:UpdateRemotePlugins
:CocInstall coc-css coc-tsserver coc-html coc-json coc-tslint
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
