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
# enable menu selection for completion
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit
# End of lines added by compinstall

#------------------------------------------------------------------------------
#                               Options
#------------------------------------------------------------------------------
# Enable autocompletion of hidden files without typing a dot at the start
setopt globdots
setopt autoparamslash       # tab completing directory appends a slash
setopt correct              # command auto-correction
setopt correctall           # argument auto-correction

#-------------------------------------------------------------------------------
#                         Shell helper functions
#-------------------------------------------------------------------------------
autoload -U add-zsh-hook

function auto-ls-after-cd() {
  emulate -L zsh
  # Only in response to a user-initiated `cd`, not indirectly (eg. via another
  # function).
  if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
    ls -a
  fi
}
add-zsh-hook chpwd auto-ls-after-cd

#-------------------------------------------------------------------------------
#                      Setup and load external tools
#-------------------------------------------------------------------------------
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

