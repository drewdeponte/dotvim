" enable project specific .vimrc files
set exrc

" set the clipboard to unnamed so it uses the system clipboard
" set clipboard=unnamed

" Set the visual bell instead of audible
set vb

" tell vim NOT to run in Vi compatible mode
set nocompatible

" show line numbers
set relativenumber
set number
set ruler

" set regexp engine to old one full featured one. Turns out that the newer NFA
" regexp engine does NOT play nice with Ruby lang syntax highlighting.
" Switching to the older non NFA regexp engine drastically increases
" performance.
if exists('+regexpengine')
  set regexpengine=1
endif

" keep buffers opened in background until :q or :q!
set hidden

" Number of : command entries to keep track of as history
set history=10000

" Set the word wrap character limit, this will force word wrap past the
" specified column.
set textwidth=80

" Set the visual color column. This is usually used to indicate the text wrap
" boundaries.
" set colorcolumn=79

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
set cmdheight=1

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

" enable syntax
syntax on

" let g:completor_python_binary='/usr/bin/python'
" let g:completor_racer_binary='/Users/adeponte/.cargo/bin/racer'
" let g:completor_clang_binary='/usr/bin/clang'
let g:completor_completion_delay=10
let g:completor_disable_filename=1
let g:completor_disable_ultisnips=1
" let g:completor_auto_trigger=0
" inoremap <exp> <Tab> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"

" Commented these out because they impact performance of opening a file for
" editing slightly. So, I at least want to keep them out until I find the
" major performance issue with opening a file for editing.
" " enable automatic code folder on indent
" set foldmethod=syntax
" 
" " do NOT fold by default
" set nofoldenable
" 
" " number of levels to auto fold when open a file
" set foldlevel=1

" Set my leader key to be a comma
let mapleader = ","

if has("autocmd")
  " Enable file type detection and indetation.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Note: I do not use 'filetype plugin indent on' as it seriously tanks
  " performance of opening at least ruby files for editing. The
  " bundle/vim-rake plugin also triggers `filetype plugin on` which also tanks
  " performance of opening at least ruby files for editing.
endif

" tab completion mode for files, etc.
set wildmode=list:longest,list:full

" scan current buffer, buffers of other windows, loaded buffers in buffer
" list, unloaded buffers, tags
set complete=.,w,b,u,t

" enable menu and extra info about completion
set completeopt=menu,preview

" make tab completion for files/buffers act like bash
set wildmenu

" set ack.vim to use ag instead of ack
let g:ackprg = 'rg --vimgrep --no-heading'

" set vim-multicursor to use Ctrl-C as its quit key command
let g:multicursor_quit = "<c-c>"

" set the devnotes directory to my dotvim directory
let g:devnotes_directory = "/Users/adeponte/.vim/devnotes"

" set test-recall rspec command
let g:vim_test_recall_rspec_command = 'bundle exec rspec'

" set vim-markdown-preview to render github style using grip cmd line tool
let g:vim_markdown_preview_github=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

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
  autocmd FileType swift set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass
  autocmd! BufRead,BufNewFile *.pp setfiletype ruby
  autocmd! BufRead,BufNewFile *.god setfiletype ruby

  autocmd BufRead *.mkd,*.markdown,*.md  setl ai formatoptions=tcroqn2 comments=n:&gt tw=0 wrap linebreak spell

  " Before writing a file check if the path for it exists. If it doesn't then
  " mkdir -p the path so that the file can be saved.
  autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif

  " Indent p tags, I commented the below out because I don't have the
  " dependencies necessary to get it to work and I am not sure if I
  " actually want it. I took it from the DestoryAllSoftware vimrc screencast.
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  " autocmd! FileType mkd setlocal syn=off
  autocmd! FileType gitcommit setlocal spell
  autocmd! FileType text setlocal spell
  autocmd! FileType slack setlocal tw=0 wrap linebreak spell

  autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
  autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs setlocal makeprg=cargo

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

" Tell it to use the Alduin color scheme
" https://github.com/AlessandroYorba/Alduin
" let g:alduin_Shout_Windhelm = 1
" colorscheme alduin

" Tell it to use the solarized color scheme
" http://ethanschoonover.com/solarized
" In order to have this work properly in iTerm2 you also need to setup the
" iTerm2 solarized color scheme.
" set background=dark
" colorscheme solarized
" colorscheme zenburn
colorscheme jellybeans

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y

" zoom a vim split, <leader>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

"imap <c-n> <%<space><space>%><esc>bhi
"imap <c-r> <%=<space><space>%><esc>bhi
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
nnoremap <leader><leader> <c-^>

" make pasting correctly from system clip board easier.
map <leader>p :set paste<CR>"+]p:set nopaste<CR>
map <leader>P :set paste<CR>"+]P:set nopaste<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | ~/.vim/bin/selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all tags in the tags database, then open the tag that the user selects
command! SelectaTag :call SelectaCommand("awk '{print $1}' tags | sort -u | grep -v '^!'", "", ":tag")

fu! GetBuffers()
	let ids = filter(range(1, bufnr('$')), 'empty(getbufvar(v:val, "&bt"))'
		\ .' && getbufvar(v:val, "&bl")')
  let bufs = [[], []]
  for id in ids
    let bname = bufname(id)
    let ebname = bname == ''
    let fname = fnamemodify(ebname ? '['.id.'*No Name]' : bname, ':.')
    if bname != expand('%')
      cal add(bufs[ebname], fname)
    endif
  endfo
  retu join(bufs[0] + bufs[1], "\n")
endf

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
map <leader>gg :topleft 100 :split Gemfile<cr>

map <leader>b :call SelectaCommand("echo '" . GetBuffers() . "'", "", ":buffer")<cr>
map <leader>gv :call SelectaCommand("find app/views -type f", "", ":e")<cr>
map <leader>gm :call SelectaCommand("find app/models -type f", "", ":e")<cr>
map <leader>gh :call SelectaCommand("find app/helpers -type f", "", ":e")<cr>
map <leader>gl :call SelectaCommand("find lib -type f", "", ":e")<cr>
map <leader>gf :call SelectaCommand("find features -type f", "", ":e")<cr>

" fuzzy-match files except for stuff in tmp/*, log/*, tags
map <leader>f :call SelectaCommand("find . -path './.build' -prune -or -path './dist' -prune -or -path './.eggs' -prune -or -path './RanchHand.egg-info' -prune -or -name '*.pyc' -prune -or -path ./_site -prune -or -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -path ./" . expand('%') . " -prune -or -type f -print", "", ":e")<cr>
map <leader>gt :SelectaTag<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GIT SHORTCUTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>gp :!git push<cr>

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
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <s-tab> <c-n>

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

" Run a given vim command on the results of alt from a given path.
" See usage below.
function! AltCommand(path, vim_command)
	" let l:alternate = system("find . -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -type f -print | alt -f - " . a:path)
	let l:alternate = system("alt " . a:path)
	if empty(l:alternate)
		echo "No alternate file for " . a:path . " exists!"
	else
		exec a:vim_command . " " . l:alternate
	endif
endfunction


" map <leader>f :call SelectaCommand("find . -path ./_site -prune -or -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -path ./" . expand('%') . " -prune -or -type f -print", "", ":e")<cr>

" Find the alternate file for the current path and open it
nnoremap <leader>. :w<cr>:call AltCommand(expand('%'), ':e')<cr> 
" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunAllTestsInCurrentTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunAllRSpecTests()<cr>

" Ping the cursor like an old radar to find it fast
nnoremap <leader>C :PingCursor<cr>

" XCode
nnoremap <leader>xb :Xbuild<cr>
nnoremap <leader>xt :Xtest<cr>
nnoremap <leader>xr :Xrun<cr>
nnoremap <leader>xc :Xclean<cr>

" disable unsafe commands in project specific .vimrc files
set secure
