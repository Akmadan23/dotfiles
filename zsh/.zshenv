# DT's colorscripts: https://gitlab.com/dwt1/shell-color-scripts
# colorscripts -r

# Default apps
export TERMINAL="alacritty"
export EDITOR="nvim"
export VISUAL="$TERMINAL -e $EDITOR"
export READER="zathura"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="sxiv"
export PAGER="nvim -R"

# Setting starship's config file location
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Setting zsh history file
export HISTFILE=~/.config/zsh/.zsh_history

# Setting qt theme with qt5ct
export QT_QPA_PLATFORMTHEME="qt5ct"

# Java fix for Qtile
export _JAVA_AWT_WM_NONREPARENTING=1
