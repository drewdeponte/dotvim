
" open to overrides from others
if filereadable(expand('~/.vimrc-ext'))
  source ~/.vimrc-ext
endif


" enable pathogen to load all the vim bundles in ~/.vim/bundle/
call pathogen#infect()

" set the clipboard to unnamed so it uses the system clipboard
" set clipboard=unnamed

" Set the visual bell instead of audible
set vb

" Set the font when using MacVim.app, this is ignored for console vim as it
" simply uses the console font.
set gfn=Monaco:h15

" tell vim NOT to run in Vi compatible mode
set nocompatible

" show line numbers
set number
set ruler

" keep buffers opened in background until :q or :q!
set hidden

" Number of : command entries to keep track of as history
set history=10000

" Set the word wrap character limit, this will force word wrap past the
" specified column.
set textwidth=78

" Default to tab size of two spaces and enable auto indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" Show matching bracket when a bracket is inserted
set showmatch

" Show matching pattern as typing search pattern 
set incsearch

" Highlight searches matching the search pattern
set hlsearch

" Make searches case-sensetive only if they include upper-case characters
set ignorecase smartcase

" Highlight the line the cursor is currently on for easy spotting
" set cursorline

" Highlight the column the cursor is currently on for easy spottintg
" (Note: This seems to make even small ruby files with syntax highlighting on
" super slow when using h,l to move the cursor left or right.)
" set cursorcolumn

" Make the command entry area consume two rows
set cmdheight=2

" Set preference for switching butters, :help switchbuf for details
set switchbuf=useopen

" Min number of characters to use for line number column
set numberwidth=5

" Show tab lines always
set showtabline=2

" Soft min width for the active window
set winwidth=15

" Soft min height for the active window
set winheight=5

" Min height for non active window
set winminheight=5

" The shell to use when using :!
set shell=zsh

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" Minimum number of lines of context to keep around cursor
set scrolloff=3

" Settings for file swaps and backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" show incomplete command
set showcmd

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" enable syntax
syntax on

" enable automatic code folder on indent
set foldmethod=syntax

" do NOT fold by default
set nofoldenable

" number of levels to auto fold when open a file
set foldlevel=1

" Set my leader key to be a comma
let mapleader = ","

" Enable file type detection.
" " Use the default filetype settings, so that mail gets 'tw' set to 72,
" " 'cindent' is on in C files, etc.
" " Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" tab completion mode for files, etc.
set wildmode=longest,list

" make tab completion for files/buffers act like bash
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass
  autocmd! BufRead,BufNewFile *.pp setfiletype ruby
  autocmd! BufRead,BufNewFile *.god setfiletype ruby

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Before writing a file check if the path for it exists. If it doesn't then
  " mkdir -p the path so that the file can be saved.
  autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif

  " Indent p tags, I commented the below out because I don't have the
  " dependencies necessary to get it to work and I am not sure if I
  " actually want it. I took it from the DestoryAllSoftware vimrc screencast.
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Don't screw up folds when inserting text that might affect them, until
  " " leaving insert mode. Foldmethod is local to the window. Protect against
  " " screwing up folding when switching between windows.
  " 
  " Note: I added the following because I was seeing very bad performance when
  " using Ctrl+n or Ctrl+p or Ctrl+x Ctrl+o to do wordcompletion. I did
  " googling and found out it was due to the foldmethod=syntax and that there
  " is a work around to set foldmethod=manual while in insert mode and then
  " back to the configured value when exiting insert mode. This resolves the
  " performance issues I was having and code folding still works properly,
  " WIN!
  " http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tell it to use the solarized color scheme
" http://ethanschoonover.com/solarized
" In order to have this work properly in iTerm2 you also need to setup the
" iTerm2 solarized color scheme.
set background=dark
colorscheme solarized

" Tell it to use the ir_black color scheme
" http://blog.toddwerth.com/entries/8
" set background=dark
" colorscheme ir_black

" set background=dark
" colorscheme herald

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

" Erb statement generators
nmap <leader>- i<%<space><space>-%><esc>bhi
nmap <leader>= i<%=<space><space>%><esc>bhi
imap <leader>- <%<space><space>-%><esc>bhi
imap <leader>= <%=<space><space>%><esc>bhi

"imap <c-n> <%<space><space>%><esc>bhi
"imap <c-r> <%=<space><space>%><esc>bhi
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
nnoremap <leader><leader> <c-^>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC CtrlP TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . _ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
map <leader>gv :CtrlP app/views<cr>
map <leader>gc :CtrlP app/controllers<cr>
map <leader>gm :CtrlP app/models<cr>
map <leader>gh :CtrlP app/helpers<cr>
map <leader>gl :CtrlP lib<cr>
map <leader>gp :CtrlP public<cr>
map <leader>gs :CtrlP public/stylesheets/sass<cr>
map <leader>gf :CtrlP features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CtrlPTag<cr>
map <leader>f :CtrlP<cr>
map <leader>F :CtrlP %%<cr>
map <leader>b :CtrlPBuffer<cr>

" jump to buffer if already open, even if in another tab
let g:ctrlp_switch_buffer = 2
" set the local working directory to the nearest .git/ .hg/ .svn/ .bzr/
let g:ctrlp_working_path_mode = 2
" enable cross-session caching by not deleting cache files on exit
let g:ctrlp_clear_cache_on_exit = 0
" set the best match to be the top
let g:ctrlp_match_window_reversed = 0
" set max height of match window
let g:ctrlp_max_height = 20
" tell ctrlp to ignore some files
let g:ctrlp_custom_ignore = 'tags$\|\.DS_Store$\|\.git$\|_site$'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" Alternate between test files and paired code files
nnoremap <leader>. :OpenAlternate<cr>

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunAllTestsInCurrentTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunAllRSpecTests()<cr>
map <leader>c :call RunAllCucumberFeatures()<cr>
map <leader>w :call RunWipCucumberFeatures()<cr>

" Ping the cursor like an old radar to find it fast
nnoremap <leader>p :PingCursor<cr>
