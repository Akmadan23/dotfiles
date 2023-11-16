ZDIR="$XDG_CONFIG_HOME/zsh"

# Modules
source "$ZDIR/misc.zsh"
source "$ZDIR/keybindings.zsh"
source "$ZDIR/aliases.zsh"
source "$ZDIR/aliases-flatpak.zsh"

# Plugins
source "$ZDIR/plugins/zsh-autopair/autopair.zsh"
source "$ZDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# Enable zoxide
eval "$(zoxide init zsh)"

# Enable starship
eval "$(starship init zsh)"

# Autostart
pfetch
