#!/bin/sh

# Install Vundle
which git
if [ $? -eq 1 ]; then
        echo "git is not installed"
        exit 1
fi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Link configuration files
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -s $DIR/.tmux.conf ~/.tmux.conf
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.bashrc ~/.bashrc
ln -s $DIR/.bash_profile ~/.bash_profile
ln -s $DIR/.xmonad ~/.xmonad
ln -s $DIR/.Xdefaults ~/.Xdefaults
ln -s $DIR/.xmonad/xmonad-start.sh ~/.xsession
mkdir -p ~/.vim/temp

vim -c PluginInstall
