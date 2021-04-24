# Setting path for binaries
PATH="/usr/bin":"/usr/sbin":"/usr/local/bin":"/usr/local/sbin":"$HOME/.local/bin":"$HOME/.cargo/bin":"$HOME/.config/scripts"
export PATH

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
export MANPAGER="nvim -c 'set ft=man'"
export OPENER="xdg-open"

# Setting starship's config file location
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Setting zsh history file
export HISTFILE=~/.config/zsh/.zsh_history

# Disabling GTK3 client side decorations
export GTK_CSD=0
export LD_PRELOAD=~/.config/gtk3-nocsd/libgtk3-nocsd.so.0

# Setting trash directory
export TRASH=~/.local/share/Trash/files/

# Disabling default ranger config
export RANGER_LOAD_DEFAULT_RC=false

# Qt settings
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_DEVICE_PIXEL_RATIO=0
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCREEN_SCALE_FACTORS=1
export QT_SCALE_FACTOR=1

# Java fix for Qtile
export _JAVA_AWT_WM_NONREPARENTING=1
