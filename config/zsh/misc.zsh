# Case insensitive tab-completion
autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zmodload zsh/complist

# History configuration (https://zsh.sourceforge.io/Doc/Release/Options.html#History)
opts=(extended_history hist_ignore_all_dups hist_ignore_space share_history)

for opt in $opts; do
    setopt $opt
done

# Remove mode switching delay
KEYTIMEOUT=5

# Change cursor shape for different vi modes
zle-keymap-select() {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = "block" ]]; then
        echo -ne "\e[2 q"
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = "" ]] || [[ $1 = "beam" ]]; then
        echo -ne "\e[5 q"
    fi
}

zle -N zle-keymap-select

expand_alias() {
    a=${aliases[$1]}

    if [ -z "$a" ]; then
        a=$cmd
    fi

    echo $a | sed "s/ .*//g"
}

# Use beam shape cursor for each new prompt
precmd()    { print -Pn -- "\e]2;[%n@%m] %~\a"; echo -ne "\e[5 q"; }
preexec()   { print -Pn -- "\e]2;[%n@%m] $(expand_alias $1)\a"; }
