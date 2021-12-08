#!/bin/sh

# Alacritty
mkdir -p ~/.config/alacritty/
cp -r alacritty/* ~/.config/alacritty/

# htop
mkdir -p ~/.config/htop/
cp -r htop/* ~/.config/htop/

# bspwm
mkdir -p ~/.config/bspwm/
cp -r bspwm/* ~/.config/bspwm/

# sxhkd
mkdir -p ~/.config/sxhkd/
cp -r sxhkd/* ~/.config/sxhkd/

# nvim
mkdir -p ~/.config/nvim/
cp -r nvim/* ~/.config/nvim/
curl -fLo ~/.config/nvim/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# qtile
mkdir -p ~/.config/qtile/
cp -r qtile/* ~/.config/qtile/

# xmonad
mkdir -p ~/.config/xmonad/
cp -r xmonad/* ~/.config/xmonad/

# xmobar
mkdir -p ~/.config/xmobar/
cp -r xmobar/* ~/.config/xmobar/

# ranger
mkdir -p ~/.config/ranger/
cp -r ranger/* ~/.config/ranger/

# joshuto
mkdir -p ~/.config/joshuto/
cp -r joshuto/* ~/.config/joshuto/

# rofi
mkdir -p ~/.config/rofi/
cp -r rofi/* ~/.config/rofi/
ln -s ~/.config/rofi/scripts/* ~/.local/bin/

# zathura
mkdir -p ~/.config/zathura/
cp -r zathura/* ~/.config/zathura/

# dunst
mkdir -p ~/.config/dunst/
cp -r dunst/* ~/.config/dunst/

# conky
mkdir -p ~/.config/conky/
cp -r conky/* ~/.config/conky/

#mpv
mkdir -p ~/.config/mpv/scripts/
cp -r mpv/* ~/.config/mpv/
cd ~/.config/mpv/
wget https://github.com/TheAMM/mpv_thumbnail_script/releases/download/0.4.2/mpv_thumbnail_script_client_osc.lua
wget https://github.com/TheAMM/mpv_thumbnail_script/releases/download/0.4.2/mpv_thumbnail_script_server.lua
cp mpv_thumbnail_script_server.lua mpv_thumbnail_script_server_bis.lua
cd -

# starship
mkdir -p ~/.config/starship/
cp -r starship/* ~/.config/starship/
curl -fsSL https://starship.rs/install.sh | bash

# flameshot 
mkdir -p ~/.config/Dharkael/
cp misc/* ~/.config/Dharkael/

# zsh 
mkdir -p ~/.config/zsh/plugins/
cp zsh/.zsh* ~/.config/zsh/
cd ~/.config/zsh/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
cd -

# Xresources
cp .Xresources ~

# Git
cp .gitconfig ~
