# ~/.profile: executed by the command interpreter for login shells.
# .zprofile is symlinked to this file

# set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_SCALE_FACTOR=1
export QT_AUTO_SCREEN_SCALE_FACTOR=0 # stop dpi aware apps from scaling twice
export TERMINAL=kitty
export JAVA_HOME=/usr/lib/jvm/default
export EDITOR=nvim

# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/chromium

# Start ssh-agent on startup
# The key is added automatically on first use
# thanks to "AddKeysToAgent yes" setting in ~/ssh/config
[ -z "$SSH_AUTH_SOCK" ] && eval $(ssh-agent)

# System specific stuff
[ -f $HOME/.profile.local ] && . $HOME/.profile.local
