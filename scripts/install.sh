#!/bin/sh

# Alacritty
mkdir -p ~/.config/alacritty/
cp -r alacritty/* ~/.config/alacritty/

# Awesome
mkdir -p ~/.config/awesome/
cp -r awesome/* ~/.config/awesome/

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

# qtile
mkdir -p ~/.config/qtile/
cp -r qtile/* ~/.config/qtile/

# ranger
mkdir -p ~/.config/ranger/
cp -r ranger/* ~/.config/ranger/

# rofi
mkdir -p ~/.config/rofi/
cp -r rofi/* ~/.config/rofi/
cp rofi/scripts/* ~/.local/bin/

# wlogout
mkdir -p ~/.config/wlogout/
cp -r wlogout/* ~/.config/wlogout/

# zathura
mkdir -p ~/.config/zathura/
cp -r zathura/* ~/.config/zathura/

# dunst
mkdir -p ~/.config/dunst/
cp -r dunst/* ~/.config/dunst/

# zsh 
cp zsh/.zshrc ~/
cp zsh/.zshenv ~/

# X
cp .Xresources ~
cp .Xinitrc ~
