#     _    _                        _             ____  _____
#    / \  | | ___ __ ___   __ _  __| | __ _ _ __ |___ \|___ /
#   / _ \ | |/ / '_ ` _ \ / _` |/ _` |/ _` | '_ \  __) | |_ \
#  / ___ \|   <| | | | | | (_| | (_| | (_| | | | |/ __/ ___) |
# /_/   \_\_|\_\_| |_| |_|\__,_|\__,_|\__,_|_| |_|_____|____/
#
# Archive extraction function
ext() {
    if [ -z $1 ]; then
        echo "Please select a file."
    elif [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1   ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *.deb)       ar x $1      ;;
            *.tar.xz)    tar xf $1    ;;
            *.tar.zst)   unzstd $1    ;;      
            *)           echo "'$1' cannot be extracted via ext" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Adding case insensitive tab-completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Plugins
source $ZDOTDIR/plugins/history.zsh
source $ZDOTDIR/plugins/key-bindings.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###############################################################
#                          ALIASES                            #
###############################################################

# Using alias after "sudo"
alias sudo="sudo "

# Config files
alias vw="$EDITOR ~/Documenti/git-repos/vimwiki/index.wiki"
alias zenv="$EDITOR ~/.config/zsh/.zshenv"
alias zhist="$EDITOR ~/.config/zsh/.zsh_history"
alias zconf="$EDITOR ~/.config/zsh/.zshrc"
alias xconf="$EDITOR ~/.Xresources"
alias rconf="$EDITOR ~/.config/ranger/rc.conf"
alias qconf="$EDITOR ~/.config/qtile/config.py"
alias qaconf="$EDITOR ~/.config/qtile/autostart.sh"
alias vconf="$EDITOR ~/.config/nvim/init.vim"
alias vpconf="$EDITOR ~/.config/nvim/plugins.vim"
alias vkconf="$EDITOR ~/.config/nvim/keybindings.vim"
alias alconf="$EDITOR ~/.config/alacritty/alacritty.yml"
alias awconf="$EDITOR ~/.config/awesome/rc.lua"
alias i3conf="$EDITOR ~/.config/i3/config"
alias pbconf="$EDITOR ~/.config/polybar/config"
alias kbconf="$EDITOR ~/.config/sxhkd/sxhkdrc"
alias bspconf="$EDITOR ~/.config/bspwm/bspwmrc"
alias ffconf="$EDITOR ~/.mozilla/firefox/1g4xbltp.default-release-1581780025274/chrome/userChrome.css"
alias ffcolors="$EDITOR ~/.mozilla/firefox/1g4xbltp.default-release-1581780025274/chrome/userColors.css"

# Directory shorctuts
alias magnatut="cd ~/Documenti/git-repos/magnatut"
alias dotfiles="cd ~/Documenti/git-repos/dotfiles"
alias startpage="cd ~/Documenti/git-repos/startpage"
alias website="cd ~/Documenti/git-repos/azadahmadi.net"
alias ff-teal="cd ~/Documenti/git-repos/firefox-teal"
alias update-ff="cp ~/.mozilla/firefox/1g4xbltp.default-release-1581780025274/chrome/* ~/Documenti/git-repos/firefox-review/"
alias update-dotfiles="~/.config/scripts/update-dotfiles.sh"

# Appimages
alias etcher="~/Appimage/BalenaEtcher.appimage"
alias openra="~/Appimage/OpenRA.appimage"
alias krita="~/Appimage/krita-4.2.6-x86_64.appimage"

# Git
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gau="git add -u"
alias gc="git commit"
alias gd="git diff --color"
alias gca="git commit -a"
alias gpom="git push origin master"

# Replacing ls with lsd
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -lA"

# Misc
alias pm="pacman"
alias ps="ps axu | less"
alias ytdl="youtube-dl"
alias vim="nvim"
alias svim="sudo nvim"
alias tlauncher="java -jar ~/Scaricati/TLauncher-2.72/TLauncher-2.72.jar"
alias ssh-pi="ssh pi@nextcloud-pi"
alias swap="sudo swapon -v /dev/sda2"
alias vtop="vtop -t brew --update-interval 500"
alias startminer="sudo ~/Documenti/cpuminer-multi/minerd -a cryptonight -o stratum+tcp://pool.minexmr.com:4444 \
    -u 49QpUDzDBp9PJrCSJrHaEw6sVge2ehEUob6P73ZE6hy678AqxdMjLu11WXgLLEMQAyizhmooYWvME8NDfkCUEWaiMd3nbuz -p x -t 4"

###############################################################
#                          VI MODE                            #
###############################################################

# Activate vim mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}

zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
precmd() {
   echo -ne '\e[5 q'
}

# Enabling starship prompt
eval $(starship init zsh)
