# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
# bindkey -v
# End of lines configured by zsh-newuser-install

# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
# enable menu selection for completion
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit



# Start ssh-agent on startup
# The key is added automatically on first use
# thanks to "AddKeysToAgent yes" setting in ~/ssh/config
[ -z "$SSH_AUTH_SOCK" ] && eval $(ssh-agent) 1> /dev/null

#------------------------------------------------------------------------------
#                               Options
#------------------------------------------------------------------------------
# Enable autocompletion of hidden files without typing a dot at the start
setopt globdots
setopt autoparamslash       # Tab completing directory appends a slash
setopt correct              # Command auto-correction
setopt correctall           # Argument auto-correction
setopt interactivecomments  # allow comments, even in interactive shells

export EDITOR='nvim'


#-------------------------------------------------------------------------------
#                         Shell helper functions
#-------------------------------------------------------------------------------
# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

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

# adds `cdr` command for navigating to recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# enable menu-style completion for cdr
zstyle ':completion:*:*:cdr:*:*' menu selection

# fall through to cd if cdr is passed a non-recent dir as an argument
zstyle ':chpwd:*' recent-dirs-default true

#-------------------------------------------------------------------------------
#                            Prompt / Powerline
#-------------------------------------------------------------------------------
# Setup Prompt / Powerline
POWERLEVEL9K_MODE='nerdfont-complete'
DEFAULT_USER='fabio'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode background_jobs time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_HIDE_SIGNAME=true
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="white"
# Truncate path /usr/share/plasma to /u/s/plasma
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M} \uE12E"
POWERLEVEL9K_COLOR_SCHEME='dark'
POWERLEVEL9K_VCS_GIT_ICON='\uE1AA'
POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uE1AA'
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_VI_INSERT_MODE_STRING=''

#-------------------------------------------------------------------------------
#                      Setup and load external tools
#-------------------------------------------------------------------------------

# Antigen / Plugins
if [ -f ~/.config/zsh/antigen.zsh ]; then
  source ~/.config/zsh/antigen.zsh

  # load autocompletions for various tools
  antigen bundle zsh-users/zsh-completions

  # powerline9k - Command prompt
  POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
  antigen theme bhilburn/powerlevel9k powerlevel9k

  # Auto Suggestions
  antigen bundle zsh-users/zsh-autosuggestions

  antigen apply
fi

# Execute scripts that are only relevant for this machine
[ -f ~/.bashrc_local ] && . ~/.bashrc_local

# Execute fzf https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Node Version Manager https://github.com/creationix/nvm#installation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add yarn to path for globally installed yarn packages
export PATH="$(yarn global bin):$PATH"

#-------------------------------------------------------------------------------
#                      Load Aliases and utility functions
#-------------------------------------------------------------------------------
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
