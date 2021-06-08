#     _    _                        _             ____  _____
#    / \  | | ___ __ ___   __ _  __| | __ _ _ __ |___ \|___ /
#   / _ \ | |/ / '_ ` _ \ / _` |/ _` |/ _` | '_ \  __) | |_ \
#  / ___ \|   <| | | | | | (_| | (_| | (_| | | | |/ __/ ___) |
# /_/   \_\_|\_\_| |_| |_|\__,_|\__,_|\__,_|_| |_|_____|____/

# Case insensitive tab-completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
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

# Config files
alias vw="$EDITOR ~/Documenti/git-repos/vimwiki/notes/index.wiki"
alias zenv="$EDITOR ~/.config/zsh/.zshenv"
alias zhist="$EDITOR ~/.config/zsh/.zsh_history"
alias zconf="$EDITOR ~/.config/zsh/.zshrc"
alias xconf="$EDITOR ~/.Xresources"
alias rconf="$EDITOR ~/.config/ranger/rc.conf"
alias lconf="$EDITOR ~/.config/leftwm/config.toml"
alias qconf="$EDITOR ~/.config/qtile/config.py"
alias qaconf="$EDITOR ~/.config/qtile/autostart.sh"
alias vconf="$EDITOR ~/.config/nvim/init.vim"
alias vkconf="$EDITOR ~/.config/nvim/keybindings.vim"
alias alconf="$EDITOR ~/.config/alacritty/alacritty.yml"
alias i3conf="$EDITOR ~/.config/i3/config"
alias kbconf="$EDITOR ~/.config/sxhkd/sxhkdrc"
alias bspconf="$EDITOR ~/.config/bspwm/bspwmrc"
alias pbconf="$EDITOR ~/.config/polybar/config -c 'set ft=toml'"

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
alias vim="nvim"
alias vfz="cd /tmp/fz3temp-2/ && vim -p *.* && cd -"
alias ytdl="youtube-dl"
alias swap="sudo swapon -v /dev/sda2"
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
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Removing mode switching delay.
KEYTIMEOUT=5

# Changing cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[2 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}

zle -N zle-keymap-select

# Use beam shape cursor for each new prompt.
precmd() {
   echo -ne '\e[5 q'
}

# Enabling starship prompt
eval $(starship init zsh)
