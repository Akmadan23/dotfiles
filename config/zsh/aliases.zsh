# Jump back directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Config files
alias xconf="nvim $HOME/.Xresources"
alias lconf="nvim $XDG_CONFIG_HOME/leftwm/config.toml"
alias zconf="nvim -p \
    $HOME/.zshenv \
    $HOME/.zshrc \
    $XDG_CONFIG_HOME/zsh/misc.zsh \
    $XDG_CONFIG_HOME/zsh/aliases.zsh \
    $XDG_CONFIG_HOME/zsh/keybindings.zsh"
alias rconf="nvim -p \
    $XDG_CONFIG_HOME/ranger/rc.conf \
    $XDG_CONFIG_HOME/ranger/rifle.conf \
    $XDG_CONFIG_HOME/ranger/scope.sh"
alias qconf="nvim -p $XDG_CONFIG_HOME/qtile/*.py"
alias vconf="nvim -p \
    $XDG_CONFIG_HOME/nvim/init.lua \
    $XDG_CONFIG_HOME/nvim/lua/options.lua \
    $XDG_CONFIG_HOME/nvim/lua/plugins.lua \
    $XDG_CONFIG_HOME/nvim/lua/keymaps.lua \
    $XDG_CONFIG_HOME/nvim/lua/autocmds.lua \
    $XDG_CONFIG_HOME/nvim/lua/functions.lua \
    $XDG_CONFIG_HOME/nvim/colors/monokai.lua"
alias jconf="nvim -p $XDG_CONFIG_HOME/joshuto/*.toml"
alias xmconf="nvim -p \
    $XDG_CONFIG_HOME/xmonad/xmonad.hs \
    $XDG_CONFIG_HOME/xmobar/xmobar.hs"
alias dkconf="nvim -p \
    $XDG_CONFIG_HOME/dk/dkrc \
    $XDG_CONFIG_HOME/dk/sxhkdrc"
alias bspconf="nvim -p \
    $XDG_CONFIG_HOME/bspwm/bspwmrc \
    $XDG_CONFIG_HOME/sxhkd/sxhkdrc"
alias alconf="nvim -p \
    $XDG_CONFIG_HOME/alacritty/alacritty.yml \
    $XDG_CONFIG_HOME/alacritty/colorscheme.yml \
    $XDG_CONFIG_HOME/alacritty/keybindings.yml"
alias pbconf="nvim $XDG_CONFIG_HOME/polybar/config -c 'set ft=toml'"
alias asconf="nvim ~/git-repos/dotfiles/autostart.csv"
alias kconf="sudo nvim /usr/share/X11/xkb/symbols/pc"

# git
alias gs="git status"
alias gS="git stash"
alias gp="git push"
alias gP="git pull"
alias ga="git add"
alias gA="git add -A"
alias gau="git add -u"
alias grm="git rm -r"
alias gmv="git mv"
alias gr="git restore"
alias grs="git restore --staged"
alias gd="git diff"
alias gds="git diff --staged"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gb="git branch"
alias gck="git checkout"

# ls
alias ls="lsd -l"
alias la="lsd -lA"
alias tree="lsd --tree --group-dirs last"

# cp, mv, md, rm
alias cp="cp -v"
alias mv="mv -v"
alias md="mkdir -pv"
alias rm="trash"

# Neovim
alias v="nvim -p"
alias vc="nvim --clean"
alias vs="nvim .session.lua"
alias sv="sudo nvim"

# Docker
alias d="docker"
alias dc="docker compose"
alias di="docker image"
alias dn="docker network"
alias dv="docker volume"

# Misc
alias se="sudoedit"
alias ps="ps axu | less"
alias btm="btm -b"
alias grep="grep --color"
alias ytdl="yt-dlp"
alias cups="xdg-open localhost:631"
alias pping="prettyping"
alias src="source ~/.zshrc && source ~/.zshenv"
