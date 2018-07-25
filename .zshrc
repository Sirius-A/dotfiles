# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

autoload -Uz compinit
compinit
# End of lines added by compinstall


#------------------------------------------------------------------
#                       Custom stuff
#------------------------------------------------------------------

# Enable autocompletion of hidden files without typing a dot at the start
setopt globdots

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

