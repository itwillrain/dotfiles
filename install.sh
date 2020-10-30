#!/bin/sh

# symlink dotfiles
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/fish ~/.config/fish
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.commit_template ~/.commit_template

# update
# source ~/dotfiles/fish/config.fish
# source ~/dotfiles/fish/init.vim
# source ~/dotfiles/.tmux.conf
