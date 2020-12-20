# DT's colorscripts: https://gitlab.com/dwt1/shell-color-scripts
# colorscripts -r

# Default apps
export TERMINAL="/usr/bin/alacritty"
export EDITOR="/usr/bin/nvim"
export VISUAL="$TERMINAL -e $EDITOR"
export READER="zathura"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="sxiv"
export PAGER="less"

# Setting starship's config file location
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Setting zsh history file
export HISTFILE=~/.config/zsh/.zsh_history

# Qt settings
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_DEVICE_PIXEL_RATIO=0;
export QT_AUTO_SCREEN_SCALE_FACTOR=1;
export QT_SCREEN_SCALE_FACTORS=1;
export QT_SCALE_FACTOR=1;

# Java fix for Qtile
export _JAVA_AWT_WM_NONREPARENTING=1
