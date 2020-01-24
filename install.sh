!/bin/fish
# symlink dotfiles
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/fish ~/.config/fish
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# update
source ~/dotfiles/.config/fish/config.fish
source ~/dotfiles/.config/fish/init.vim
source ~/dotfiles/.tmux.conf
