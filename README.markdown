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

## Color Scheme

My `.vimrc` is setup to use the Solarized Color Scheme which can be found at
[http://ethanschoonover.com/solarized](http://ethanschoonover.com/solarized).
My `.vim` directory includes this color scheme as Git submodule just like all
the plugins. The reason I mention this is because I have it configured to use
the non 256 degraded Vim color version. This requires that you are using the
Solarized Color Scheme for your terminal application as well. I for example am
using [iTerm 2](http://www.iterm2.com/) with the Solarized iTerm 2 color scheme
presets.

## Quick Guide

### Functionality Provided by my vimrc

The `<leader>` key in my `.vimrc` is set to the `,` key.

#### Tab Completion

In insert mode when you start typing and hit tab it will bring up the tab completion interface.

* `<leader>n` - rename the current file
* `<leader>.` - switch between test & implementation code (assumes RSpec, Cucumber, and Ruby)

#### Running Tests

* `<leader>t` - run all tests defined in the current file and store as last test run if in test file, run last stored test run if in implementation file.
* `<leader>T` - run test nearest cursor in current file and store as last test run if in test file, run last stored test run if in implementation file.

#### Generic Fuzzy Matching

* `<leader>f` - fuzzy match all files under the project root directory 
* `<leader>F` - fuzzy match all files under the directory parenting the file currently being edited
* `<leader>b` - fuzzy match all files with buffers currently opened in the vim session

#### Ruby & Rails Fuzzy Matching/Quick Editing

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

### Plugin Provided Functionality

The following are plugins that my .vim directory includes as Git submodules for
easy upgrading. Below I also provide the commands that I find I use most often
from each of the plugins.

#### vim-surround

Provides functionality to easily manage surroundings parens, quotes, etc.
[http://github.com/tpope/vim-surround](http://github.com/tpope/vim-surround)

* `cst'` - change surrounding html tag to single quotes 
* `cs'<p>` - change surrounding single quotes to `<p>` html tag
* `cs'"` - change surrounding single quotes to double quotes
* `ds"` - delete surrounding double quotes
* `ysiw'` - add surrounding of single quote inside word (iw) where iw is a text object

#### tcomment_vim

Provides easy to use file-type sensible comments.
[http://github.com/tomtom/tcomment_vim](http://github.com/tomtom/tcomment_vim)

* `gc{motion}` - toggle comments
* `gC{motion}` - comment region
* `gcc` - toggle comment current line
* `gCc` - comment current line
* `gc` (visual mode) - toggle comments
* `gC` (visual mode) - comment selected text

#### gist-vim

Provides easy creation of GitHub Gists.
[http://github.com/mattn/gist-vim](http://github.com/mattn/gist-vim)

* `:Gist` - post current buffer to gist
* `:'<,'>Gist` - post current selection to gist
* `:Gist -p` - create private gist
* `:Gist -P` - create public gist
* `:Gist -l` - list your public gists

#### ack.vim

Provides interface to Ack from within vim.
[http://github.com/mileszs/ack.vim](http://github.com/mileszs/ack.vim)

* `:Ack [options] {pattern}` - search for specified pattern showing results in vim quick fix window.

#### vim-rails

Provides bunch of Ruby on Rails specific functionality.
[http://github.com/tpope/vim-rails](http://github.com/tpope/vim-rails)

* `gf` - gives the standard `gf` command knowledge about partials, fixtures, and much more.

#### vim-markdown

Provides syntax highlighting for Markdown files.
[http://github.com/tpope/vim-markdown](http://github.com/tpope/vim-markdown)

#### vim-cucumber

Provides syntax highlighting for Cucumber features and step definitions
[http://github.com/tpope/vim-cucumber](http://github.com/tpope/vim-cucumber)

#### vim-fugitive

Provides full blown Git interface inside of Vim. This is very valuable in my
opinion and is worth spending some time learning as it will make your life much
easier.
[http://github.com/tpope/vim-fugitive](http://github.com/tpope/vim-fugitive)

## Extending and Overriding

Inject your own changes into the existing vim functionality by adding extended
versions of .vimrc and .gvimrc in your home directory. If you add files named
`.vimrc-ext` and `.gvimrc-ext` to your home directory, they are sourced at the top
of the vimrc and gvimrc files in this project. Any functions or settings you
add to those files will be available in vim sessions. 

This makes it easy for you to try out this project without losing your
existing vim settings. Simply rename your existing .vimrc to .vimrc-ext and
our .gvimrc to .gvimrc-ext and restart vim. If you don't already have your
settings, we've included `*-ext-example` files in the project. If you want to
try them out, either either move them into your home directory with the proper
names or set symbolic links in your home directory as follows:

ln -s .vim/vimrc-ext-example .vimrc-ext
ln -s .gvim/gvimrc-ext-example .gvimrc-ext
