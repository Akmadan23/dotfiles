# Setting XDG default dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

# Setting zsh history file
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Setting less history file
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# Setting GNUPG home directory
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Setting cargo home directory
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Setting android home directory
export ANDROID_HOME="$XDG_DATA_HOME/android"

# Setting nimble home directory
export NIMBLE_DIR="$XDG_DATA_HOME/nimble"

# Setting Xmonad config directory
export XMONAD_CONFIG_DIR="$XDG_CONFIG_HOME/xmonad"

# Setting starship config file
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

# Setting clipmenu launcher
export CM_LAUNCHER="rofi"

# Setting scripts directory
export SCRIPTS="$HOME/git-repos/dotfiles/scripts"

# Setting default apps
export TERMINAL="alacritty"
export TERMCMD="alacritty"
export VISUAL="nvim"
export EDITOR="nvim"
export READER="zathura"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="nsxiv"
export PAGER="less"
export MANPAGER="nvim -M +Man!"
export OPENER="xdg-open"

# Pfetch
export PF_INFO="ascii title os host kernel uptime wm shell memory palette"
export PF_COL1="6"  # Fields
export PF_COL2="7"  # Details
export PF_COL3="1"  # Title

# Disabling GTK3 client side decorations
export GTK_CSD=0
export LD_PRELOAD="/usr/lib/libgtk3-nocsd.so.0"

# Qt settings
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCREEN_SCALE_FACTORS=1
export QT_DEVICE_PIXEL_RATIO=0
export QT_SCALE_FACTOR=1

# Java fix for Qtile
export _JAVA_AWT_WM_NONREPARENTING=1

# Setting jdtls home for nvim-jdtls plugin
export JDTLS_HOME="/usr/share/java/jdtls"

# Setting path for binaries
export PATH="/usr/bin":"/usr/local/bin":"$HOME/.local/bin":"$CARGO_HOME/bin":"$NIMBLE_DIR/bin":"$SCRIPTS"
