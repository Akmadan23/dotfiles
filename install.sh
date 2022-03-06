#!/bin/sh

# every directory inside ~/.config
for i in */; do
    cp -rvi $i ~/.config/
done

# dotfiles in the home directory
cp .zshrc       ~
cp .zshenv      ~
cp .gitconfig   ~
cp .Xresources  ~
cp .stalonetray ~

# nvim plugin manager
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# zsh plugins
mkdir -p ~/.config/zsh/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/
