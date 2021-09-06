# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
zstyle ':completion:*' special-dirs true

autoload -Uz compinit
compinit

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
# setopt inc_append_history   # Appends every command to the history file once it is executed
# setopt share_history        # Reloads the history whenever you use it
setopt HIST_IGNORE_DUPS     # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.

export EDITOR='nvim'

bindkey '^[[3~' delete-char

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
# if [ -f ~/.config/zsh/antigen.zsh ]; then
#   source ~/.config/zsh/antigen.zsh

#   # load autocompletions for various tools
#   antigen bundle zsh-users/zsh-completions

#   # FZF aliases for git
#   antigen bundle 'wfxr/forgit'

#   antigen theme romkatv/powerlevel10k

#   # Auto Suggestions
#   antigen bundle zsh-users/zsh-autosuggestions

#   antigen bundle 'zdharma/zsh-diff-so-fancy'

#   antigen apply
# fi

# Install and update zinit.zsh
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node
# End of Zinit's installer chunk

# Zinit plugins
zinit for \
  light-mode zsh-users/zsh-autosuggestions \
  light-mode wfxr/forgit \
  light-mode zdharma/zsh-diff-so-fancy \
  light-mode clarketm/zsh-completions \
  light-mode kazhala/dotbare

zinit as"depth=1" for \
  light-mode romkatv/powerlevel10k


#-------------------------------------------------------------------------------
#                            Prompt / Powerline
#-------------------------------------------------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

#-------------------------------------------------------------------------------
#                            Setup shell environment

# Set window title for urxvt and co.
case "$TERM" in
xterm*|rxvt*|alacritty*)
    precmd () {print -Pn "\e]0;%~ - Alacritty \a"}
    ;;
esac

# Tell rg to read its config file
export RIPGREP_CONFIG_PATH=~/.config/.ripgreprc

# Execute fzf https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Use rg so only relevant files are selected
export FZF_DEFAULT_COMMAND='rg --files --hidden'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# start the agent automatically and ensure that only one ssh-agent process runs
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

#-------------------------------------------------------------------------------
#                      Load Aliases and utility functions
#-------------------------------------------------------------------------------
[ -f ~/.aliases.sh ] && source ~/.aliases.sh

# Node Version Manager https://github.com/creationix/nvm#installation
# Made shell startup faster: https://blog.yo1.dog/better-nvm-lazy-loading/
# use type -t in bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Lazy loads nvm
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
  nvm $@
}

# Resolve the default node version (recursively)
DEFAULT_NODE_VER="$( (< "$NVM_DIR/alias/default" || < ~/.nvmrc) 2> /dev/null)"
while [ -s "$NVM_DIR/alias/$DEFAULT_NODE_VER" ] && [ ! -z "$DEFAULT_NODE_VER" ]; do
  DEFAULT_NODE_VER="$(<"$NVM_DIR/alias/$DEFAULT_NODE_VER")"
done

# Add the default node version to PATH
if [ ! -z "$DEFAULT_NODE_VER" ]; then
  export PATH="$NVM_DIR/versions/node/v${DEFAULT_NODE_VER#v}/bin:$PATH"
fi

# Add yarn to path for globally installed yarn packages
# (`yarn global bin` would be better but slow as it stats the nvm usage)
export PATH="$PATH:$HOME/.yarn/bin"


