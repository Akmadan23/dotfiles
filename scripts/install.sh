#!/bin/sh

# Alacritty
mkdir -p ~/.config/alacritty/
cp alacritty/* ~/.config/alacritty/

# Awesome
mkdir -p ~/.config/awesome/
cp awesome/* ~/.config/awesome/

# bspwm
mkdir -p ~/.config/bspwm/
cp bspwm/* ~/.config/bspwm/

# sxhkd
mkdir -p ~/.config/sxhkd/
cp sxhkd/* ~/.config/sxhkd/

# i3
mkdir -p ~/.config/i3/
cp i3/* ~/.config/i3/

# nvim
mkdir -p ~/.config/nvim/
cp nvim/* ~/.config/nvim/

# qtile
mkdir -p ~/.config/qtile/
cp qtile/* ~/.config/qtile/

# ranger
mkdir -p ~/.config/ranger/
cp ranger/* ~/.config/ranger/

# rofi
mkdir -p ~/.config/rofi/
cp rofi/* ~/.config/rofi/

# wlogout
mkdir -p ~/.config/wlogout/
cp wlogout/* ~/.config/wlogout/

# zathura
mkdir -p ~/.config/zathura/
cp zathura/* ~/.config/zathura/

# dunst
mkdir -p ~/.config/dunst/
cp dunst/* ~/.config/dunst/

# zsh 
cp zsh/.zshrc ~/
cp zsh/.zshenv ~/
