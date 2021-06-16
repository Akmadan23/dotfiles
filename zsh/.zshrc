#     _    _                        _             ____  _____
#    / \  | | ___ __ ___   __ _  __| | __ _ _ __ |___ \|___ /
#   / _ \ | |/ / '_ ` _ \ / _` |/ _` |/ _` | '_ \  __) | |_ \
#  / ___ \|   <| | | | | | (_| | (_| | (_| | | | |/ __/ ___) |
# /_/   \_\_|\_\_| |_| |_|\__,_|\__,_|\__,_|_| |_|_____|____/

# Case insensitive tab-completion
autoload -U compinit && compinit
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zmodload zsh/complist

# Plugins
source $ZDOTDIR/plugins/history.zsh
source $ZDOTDIR/plugins/key-bindings.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###############################################################
##                         ALIASES                           ##
###############################################################

# Using aliases after "sudo"
alias sudo="sudo "

# Jumping back
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Config files
alias zhist="nvim ~/.config/zsh/.zsh_history"
alias xconf="nvim ~/.Xresources"
alias lconf="nvim ~/.config/leftwm/config.toml"
alias zconf="nvim -p \
    ~/.config/zsh/.zshrc \
    ~/.config/zsh/.zshenv"
alias rconf="nvim -p \
    ~/.config/ranger/rc.conf \
    ~/.config/ranger/scope.sh"
alias qconf="nvim -p \
    ~/.config/qtile/config.py \
    ~/.config/qtile/autostart.sh"
alias vconf="nvim -p \
    ~/.config/nvim/init.vim \
    ~/.config/nvim/keybindings.vim"
alias jconf="nvim -p \
    ~/.config/joshuto/joshuto.toml \
    ~/.config/joshuto/keymap.toml \
    ~/.config/joshuto/mimetype.toml"
alias alconf="nvim ~/.config/alacritty/alacritty.yml"
alias i3conf="nvim ~/.config/i3/config"
alias kbconf="nvim ~/.config/sxhkd/sxhkdrc"
alias bspconf="nvim ~/.config/bspwm/bspwmrc"
alias pbconf="nvim ~/.config/polybar/config -c 'set ft=toml'"

# Git
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gau="git add -u"
alias grm="git rm"
alias grs="git restore --staged"
alias gd="git diff --color"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gpom="git push origin master"

# Replacing ls with lsd
alias ls="lsd -l --group-dirs first"
alias la="lsd -lA --group-dirs first"

# Misc
alias md="mkdir"
alias pm="pacman"
alias ps="ps axu | less"
alias ytdl="youtube-dl"
alias vim="nvim"
alias vw="nvim ~/Documenti/git-repos/vimwiki/notes/index.wiki"
alias vfz="cd /tmp/fz3temp-2/ && vim -p *.* && cd -"
alias vtop="vtop -t brew --update-interval 500"
alias tlauncher="java -jar ~/Scaricati/TLauncher/TLauncher*.jar"

###############################################################
##                         VI MODE                           ##
###############################################################

# Setting vi mode keybindings
bindkey -v
bindkey -M vicmd "H" beginning-of-line
bindkey -M vicmd "L" end-of-line
bindkey -M vicmd "U" redo

# Use vim keys in tab complete menu:
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char

# Removing mode switching delay.
KEYTIMEOUT=5

# Changing cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = "block" ]]; then
        echo -ne "\e[2 q"
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = "" ]] || [[ $1 = "beam" ]]; then
        echo -ne "\e[5 q"
    fi
}

zle -N zle-keymap-select

# Use beam shape cursor for each new prompt.
precmd() {
   echo -ne "\e[5 q"
}

# Enabling starship prompt
eval $(starship init zsh)
