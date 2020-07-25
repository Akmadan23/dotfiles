# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/azadahmadi/.oh-my-zsh"
export PATH="/home/azadahmadi/.local/bin":$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Config files
alias zshconf="micro ~/.zshrc"
alias alconf="micro ~/.config/alacritty/alacritty.yml"
alias qconf="micro ~/.config/qtile/config.py"
alias i3conf="micro ~/.config/i3/config"
alias swap="sudo swapon -v /dev/sda2"
alias displayonly="xrandr --output eDP-1 --mode 1600x900 --rotate normal --output HDMI-1 --off"
alias hdmionly="xrandr --output eDP-1 --off --output HDMI-1 --mode 1920x1080 --rotate normal"
alias dualscreen="xrandr --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 1600x0 --rotate normal"
alias tlauncher="sudo java -jar ~/Scaricati/TLauncher-2.69/TLauncher-2.69.jar"
alias ssh-pi="ssh pi@nextcloud-pi"
alias gca="git commit -a"
alias gpom="git push origin master"
alias update-qtile="cp ~/.config/qtile/* ~/Documenti/git-repos/dotfiles/qtile/"
alias update-scripts="cp ~/.config/scripts/* ~/Documenti/git-repos/dotfiles/scripts/"
alias dotfiles="cd ~/Documenti/git-repos/dotfiles"
alias ahmadi-cloud="cd ~/Doumenti/git-repos/ahmadi-cloud.in"

# Flatpaks
alias spotify="flatpak run com.spotify.Client"
alias netbeans="flatpak run org.apache.netbeans"
alias lmms="flatpak run io.lmms.LMMS"

# Appimages
alias etcher="./Appimage/balenaEtcher-1.5.57-x64_188f7ef7e14cec6f1fab92fb726026e7.AppImage"
alias openra="./Appimage/OpenRA-Red-Alert-x86_64.appimage"

# Systemctl shortcuts
alias poweroff="systemctl poweroff"
alias suspend="systemctl suspend"
alias suspend-lock="systemctl suspend && lock-script"
alias reboot="systemctl reboot"
