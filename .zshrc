# Case insensitive tab-completion
autoload -U compinit && compinit
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zmodload zsh/complist

# History configuration (https://zsh.sourceforge.io/Doc/Release/Options.html#History)
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

###############################################################
##                         KEY BINDINGS                      ##
###############################################################

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }

    function zle-line-finish() {
        echoti rmkx
    }

    zle -N zle-line-init
    zle -N zle-line-finish
fi

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
    bindkey -M viins "${terminfo[kpp]}" up-line-or-history
    bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi

# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
    bindkey -M viins "${terminfo[knp]}" down-line-or-history
    bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search

    bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search

    bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
    bindkey -M viins "${terminfo[khome]}" beginning-of-line
    bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi

# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
    bindkey -M viins "${terminfo[kend]}"  end-of-line
    bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
    bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
    bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M viins "^?" backward-delete-char

# [Ctrl-Backspace] - delete whole backward-word
bindkey -M viins "^H" backward-kill-word

# [Delete] - delete forward
bindkey -M viins "^[[3~" delete-char

# [Ctrl-Delete] - delete whole forward-word
bindkey -M viins "^[[3;5~" kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M viins "^[[1;5C" forward-word

# [Ctrl-LeftArrow] - move backward one word
bindkey -M viins "^[[1;5D" backward-word

# Plugins
source "$HOME/.config/zsh/plugins/zsh-autopair/autopair.zsh"
source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

###############################################################
##                         ALIASES                           ##
###############################################################

# Using aliases after "sudo"
alias sudo="sudo "

# Jumping back directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Config files
alias zhist="nvim ~/.config/zsh/.zsh_history"
alias xconf="nvim ~/.Xresources"
alias lconf="nvim ~/.config/leftwm/config.toml"
alias zconf="nvim -p ~/.zshrc ~/.zshenv"
alias rconf="nvim -p \
    ~/.config/ranger/rc.conf \
    ~/.config/ranger/scope.sh"
alias qconf="nvim -p \
    ~/.config/qtile/config.py \
    ~/.config/qtile/autostart.sh"
alias vconf="nvim -p \
    ~/.config/nvim/init.vim \
    ~/.config/nvim/plugins.lua \
    ~/.config/nvim/functions.vim \
    ~/.config/nvim/keybindings.vim"
alias jconf="nvim -p \
    ~/.config/joshuto/joshuto.toml \
    ~/.config/joshuto/keymap.toml \
    ~/.config/joshuto/mimetype.toml"
alias xmconf="nvim -p \
    ~/.config/xmonad/xmonad.hs \
    ~/.config/xmobar/xmobar.hs"
alias bspconf="nvim -p \
    ~/.config/bspwm/bspwmrc \
    ~/.config/sxhkd/sxhkdrc"
alias kconf="sudo nvim /usr/share/X11/xkb/symbols/pc"
alias alconf="nvim ~/.config/alacritty/alacritty.yml"
alias pbconf="nvim ~/.config/polybar/config -c 'set ft=toml'"

# Git
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gau="git add -u"
alias grm="git rm -r"
alias grs="git restore --staged"
alias gd="git diff --color"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gpom="git push origin master"

# Replacing ls and tree with lsd
alias ls="lsd -l --group-dirs first"
alias la="lsd -lA --group-dirs first"
alias tree="lsd --tree --group-dirs last"

# Vim
alias vim="nvim"
alias vfz="cd /tmp/fz3temp-2/ && vim -p *.* && cd -"
alias vwiki="nvim ~/git-repos/vimwiki/notes/index.wiki"

# cp, mv, md, rm
alias cp="cp -iv"
alias mv="mv -iv"
alias md="mkdir -pv"
alias rm="trash"

# Misc
alias ps="ps axu | less"
alias top="btm -b"
alias ytdl="youtube-dl"
alias pping="prettyping"
alias tlauncher="java -jar ~/Scaricati/TLauncher/TLauncher*.jar"
alias src="source ~/.zshrc && source ~/.zshenv"

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

# Enabling z.lua
eval "$(lua ~/.local/share/z.lua/z.lua --init zsh)"

# Enabling starship prompt
eval "$(starship init zsh)"

# Autostart
pfetch
