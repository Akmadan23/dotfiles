# Setting zsh home folder
export ZDOTDIR="$HOME/.config/zsh"

# Setting zsh history file
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Setting starship config file
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Setting Xmonad config directory
export XMONAD_CONFIG_DIR="$HOME/.config/xmonad"

# Setting cargo home folder
export CARGO_HOME="$HOME/.local/share/cargo"

# Setting clipmenu launcher
export CM_LAUNCHER="rofi"

# Setting scripts directory
export SCRIPTS="$HOME/git-repos/scripts"

# Setting trash directory
export TRASH="$HOME/.local/share/Trash/files"

# Setting default apps
export TERMINAL="alacritty"
export TERMCMD="alacritty"
export VISUAL="nvim"
export EDITOR="nvim"
export READER="zathura"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="sxiv"
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
export LD_PRELOAD="$HOME/.config/gtk3-nocsd/libgtk3-nocsd.so.0"

# Qt settings
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCREEN_SCALE_FACTORS=1
export QT_DEVICE_PIXEL_RATIO=0
export QT_SCALE_FACTOR=1

# Java fix for Qtile
export _JAVA_AWT_WM_NONREPARENTING=1

# Setting path for binaries
export PATH="/usr/bin":"/usr/sbin":"/usr/local/bin":"/usr/local/sbin":"$HOME/.local/bin":"$CARGO_HOME/bin":"$SCRIPTS"
