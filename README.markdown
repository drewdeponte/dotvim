# My .vim files

My personal `.vim` files. This repository includes my `~/.vimrc`, `~/.vim` dir, and the plugins I use as git submodules. This repository basically includes my entire vim setup so that I can easily load it onto other systems and have history of it.

## Installation:

    git clone git://github.com/cyphactor/dotvim.git ~/.vim

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

    cd ~/.vim
    git submodule init
    git submodule update

## Upgrade

    cd ~/.vim

    git pull
    git submodule init
    git submodule update
