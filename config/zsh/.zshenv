# XDG default dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

# zsh history file
export HISTFILE="$XDG_DATA_HOME/hist.zsh"
export HISTSIZE=10000
export SAVEHIST=10000

# less history file
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# GNUPG home directory
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Cargo home directory
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Cargo home directory
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Android home directory
export ANDROID_HOME="$XDG_DATA_HOME/android"

# Nimble home directory
export NIMBLE_DIR="$XDG_DATA_HOME/nimble"

# Xmonad config directory
export XMONAD_CONFIG_DIR="$XDG_CONFIG_HOME/xmonad"

# Starship config file
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

# Clipmenu launcher
export CM_LAUNCHER="rofi"

# Scripts directory
export SCRIPTS="$HOME/git-repos/dotfiles/scripts"

# Default apps
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

# nb
export NB_DIR="$XDG_DATA_HOME/nb"
export NBRC_PATH="$XDG_CONFIG_HOME/nb/nbrc"
# export NB_DIRECTORY_TOOL="ranger"
# export NB_IMAGE_TOOL="ueberzug"
# export NB_COLOR_PRIMARY=4
# export NB_COLOR_SECONDARY=8

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

# JTDLS home for nvim-jdtls plugin
export JDTLS_HOME="/usr/share/java/jdtls"

# Path for binaries
export PATH="/usr/bin":"/usr/local/bin":"$HOME/.local/bin":"$CARGO_HOME/bin":"$NIMBLE_DIR/bin":"$SCRIPTS"
