# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/fabio/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


#------------------------------------------------------------------
#                       Custom stuff
#------------------------------------------------------------------

# execute alias file if it exists
[ -f ~/.aliases ] && . ~/.aliases

# Execute scripts that are only relavant for this machine
[ -f ~/.bashrc_local ] && . ~/.bashrc_local

# Execute fzf https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Node Version Manager https://github.com/creationix/nvm#installation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add yarn to path for globally installed yarn packages
export PATH="$(yarn global bin):$PATH"

