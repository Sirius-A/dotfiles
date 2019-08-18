# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
unsetopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install

# Colorize dir lists if colors are available
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto --group-directories-first'
fi

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
setopt appendhistory        # Append history to the history file (no overwriting)
setopt inc_append_history   # Appends every command to the history file once it is executed
setopt share_history        # Reloads the history whenever you use it

export EDITOR='nvim'

# Ctrl + x, Ctrl + e opens default editor to enter a command
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

#-------------------------------------------------------------------------------
#                         Shell utility functions
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

# Automatically show files in a directory after changing to it
function auto-ls-after-cd() {
  emulate -L zsh
  # Only in response to a user-initiated `cd`, not indirectly (e.g. via another
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
#                      Setup and load external tools
#-------------------------------------------------------------------------------

# Antigen / Plugins
if [ -f ~/.config/zsh/antigen.zsh ]; then
  source ~/.config/zsh/antigen.zsh

  # load autocompletions for various tools
  antigen bundle zsh-users/zsh-completions

  antigen theme romkatv/powerlevel10k
  # Auto Suggestions
  antigen bundle zsh-users/zsh-autosuggestions

  antigen apply
fi

#-------------------------------------------------------------------------------
#                            Prompt / Powerline
#-------------------------------------------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

#-------------------------------------------------------------------------------
#                            Setup shell environment
#-------------------------------------------------------------------------------
# Execute scripts that are only relevant for this machine
[ -f ~/.bashrc_local ] && . ~/.bashrc_local

# Tell rg to read its config file
export RIPGREP_CONFIG_PATH=~/.config/.ripgreprc

# Execute fzf https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Use rg so only relevant files are selected
export FZF_DEFAULT_COMMAND='rg --files --hidden'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Node Version Manager https://github.com/creationix/nvm#installation
# Made shell startup faster: https://github.com/nvm-sh/nvm/issues/1277#issuecomment-485400399
# use type -t in bash
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -f __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'ng' 'webpack' 'simpl')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# Add yarn to path for globally installed yarn packages
# (`yarn global bin` would be better but slow as it stats the nvm usage)
export PATH="$PATH:$HOME/.yarn/bin"

#-------------------------------------------------------------------------------
#                      Load Aliases and utility functions
#-------------------------------------------------------------------------------
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
