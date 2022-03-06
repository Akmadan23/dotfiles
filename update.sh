#!/bin/sh

# every directory inside ~/.config
for i in */; do
    cp -r ~/.config/$i .
done

# dotfiles in the home directory
cp ~/.zshrc         .
cp ~/.zshenv        .
cp ~/.gitconfig     .
cp ~/.Xresources    .
cp ~/.stalonetrayrc .
