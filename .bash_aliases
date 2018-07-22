# always use neovim instead of vim or vi
alias vim='nvim'
alias vi='nvim'

# git alias to manage the bare git repo containing the dotfiles.
# See https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
