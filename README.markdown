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

## Quick Guide

The `<leader>` key in my `.vimrc` is set to the `,` key.

### Tab Completion

In insert mode when you start typing and hit tab it will bring up the tab completion interface.

* `<leader>n` - rename the current file
* `<leader>.` - switch between test & implementation code (assumes RSpec, Cucumber, and Ruby)

### Running Tests

* `<leader>t` - run all tests defined in the current file and store as last test run if in test file, run last stored test run if in implementation file.
* `<leader>T` - run test nearest cursor in current file and store as last test run if in test file, run last stored test run if in implementation file.

### Generic Fuzzy Matching

* `<leader>t` - fuzzy match tags identified using ctags
* `<leader>f` - fuzzy match all files under the project root directory 
* `<leader>F` - fuzzy match all files under the directory parenting the file currently being editid
* `<leader>b` - fuzzy match all files with buffers currently opened in the vim session

### Ruby & Rails Fuzzy Matching/Quick Editing

* `<leader>gr` - open topleft split editing Ruby on Rails routes
* `<leader>gR` - show the currently defined Ruby on Rails routes
* `<leader>gv` - fuzzy match files in the Ruby on Rails `app/views` path
* `<leader>gc` - fuzzy match files in the Ruby on Rails `app/controllers` path
* `<leader>gm` - fuzzy match files in the Ruby on Rails `app/models` path
* `<leader>gh` - fuzzy match files in the Ruby on Rails `app/helpers` path
* `<leader>gl` - fuzzy match files in the Ruby on Rails `lib` path
* `<leader>gp` - fuzzy match files in the Ruby on Rails `public` path
* `<leader>gs` - fuzzy match files in the Ruby on Rails `public/stylesheets/sass` path
* `<leader>gf` - fuzzy match files in the Ruby on Rails `features` path
* `<leader>gg` - open topleft split editing Gemfile
* `<leader>gg` - open topleft split editing Gemfile

