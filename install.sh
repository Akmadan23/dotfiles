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

# i3
mkdir -p ~/.config/i3/
cp -r i3/* ~/.config/i3/

# nvim
mkdir -p ~/.config/nvim/
cp -r nvim/* ~/.config/nvim/
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# qtile
mkdir -p ~/.config/qtile/
cp -r qtile/* ~/.config/qtile/

# ranger
mkdir -p ~/.config/ranger/
cp -r ranger/* ~/.config/ranger/

# joshuto
mkdir -p ~/.config/joshuto/
cp -r joshuto/* ~/.config/joshuto/

# rofi
mkdir -p ~/.config/rofi/
cp -r rofi/* ~/.config/rofi/
ln -s rofi/scripts/* ~/.local/bin/

# wlogout
mkdir -p ~/.config/wlogout/
cp -r wlogout/* ~/.config/wlogout/

# zathura
mkdir -p ~/.config/zathura/
cp -r zathura/* ~/.config/zathura/

# dunst
mkdir -p ~/.config/dunst/
cp -r dunst/* ~/.config/dunst/

# starship
mkdir -p ~/.config/starship/
cp -r starship/* ~/.config/starship/
curl -fsSL https://starship.rs/install.sh | bash

# flameshot 
mkdir -p ~/.config/Dharkael/
cp misc/* ~/.config/Dharkael/

# zsh 
mkdir -p ~/.config/zsh/
cp zsh/.zshrc ~/.config/zsh/
cp zsh/.zshenv ~/.config/zsh/

# X
cp .Xresources ~
cp .Xinitrc ~

# Git
cp .gitconfig ~
