# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/home/azadahmadi/.local/bin":$PATH

# Adding case insensitive tab-completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Plugins
source $ZDOTDIR/plugins/history.zsh
source $ZDOTDIR/plugins/key-bindings.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enabling starship prompt
eval $(starship init zsh)

# Config files
alias vw="$EDITOR ~/Documenti/git-repos/vimwiki/index.wiki"
alias zenv="$EDITOR ~/.config/zsh/.zshenv"
alias zhist="$EDITOR ~/.config/zsh/.zsh_history"
alias zconf="$EDITOR ~/.config/zsh/.zshrc"
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

# Xrandr settings
alias displayonly="xrandr --output eDP-1 --mode 1600x900 --rotate normal --output HDMI-1 --off"
alias hdmionly="xrandr --output eDP-1 --off --output HDMI-1 --mode 1920x1080 --rotate normal"
alias dualscreen="xrandr --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 1600x0 --rotate normal"
alias dualscreen-tv="xrandr --output eDP-1 --primary --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-1 --mode 1360x768 --pos 1600x0 --rotate normal"
alias singlescreen-tv="xrandr --output eDP-1 --off --output HDMI-1 --mode 1360x768  --rotate normal"

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
alias gca="git commit -a"
alias gpom="git push origin master"

gd() {
    if [ -z $1 ]; then
        git diff | nvim -R
    else
        git diff "$1" | nvim -R
    fi
}

# Systemctl shortcuts
alias poweroff="systemctl poweroff"
alias suspend="systemctl suspend"
alias suspend-lock="i3lock-fancy && systemctl suspend"
alias reboot="systemctl reboot"

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
