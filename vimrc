" .vimrc
" Author: Harry Marr <harry@hmarr.com>
" Source: https://github.com/hmarr/dotfiles/tree/master/vimrc

" Vundle Dependencies ============================================= {{{

set nocompatible  " be iMproved
filetype off      " required for vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'Lokaltog/vim-powerline'
Bundle 'jiangmiao/auto-pairs'
Bundle 'tpope/vim-endwise'
Bundle 'matchit.zip'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'othree/html5.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'leshill/vim-json'
Bundle 'michaeljsmith/vim-indent-object'

" }}}

" Basic Settings ================================================== {{{

" Enable syntax highlighting
syntax enable
" Use indent level from previous line
set autoindent
" Replace tabs with spaces
set expandtab
" A tab shows as 4 columns wide
set tabstop=4
" How many spaces to indent text with (using << and >>)
set shiftwidth=4
" How many columns to insert when I press TAB
set softtabstop=4
" Highlight matching brackets
set showmatch
" Show line and column in status bar
set ruler
" Search as you type
set incsearch
" Don't highlight search results
set nohls
" Case insensitive searches
set ignorecase
" Case sensitive searches when uppercase characters are used
set smartcase
" Scroll before I reach the window edge
set scrolloff=5
" Use the mouse in terminal emulators that support it
set mouse=a
" Only use one space when joining lines
set nojoinspaces
" Up the undo / redo limit
set history=1000
" Show options during tab completion
set wildmenu
" Disable vi-compatibility
set nocompatible
" Always show the statusline
set laststatus=2
" Necessary to show unicode glyphs
set encoding=utf-8
" Make backup files
set backup
" Location of backup files
set backupdir=~/.vim/backup
" Fuck swap files
set noswapfile
" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,trail:•
" Ignore crap in wildcard completion
set wildignore+=*.o,*.obj,.git,*.pyc
" Enable filetype settings (inc. indentation), files in .vim/ftplugin are read
filetype off
filetype plugin indent on

" Highlight 80th column so code can still be pretty in full-screen terminals
if exists("&colorcolumn")
    set colorcolumn=81
endif

" }}}

" GVim / MacVim Config ============================================ {{{

" Special options for gvim (instead of in .gvimrc)
let s:uname = system("echo -n \"$(uname)\"")

if has("gui_running")
    " Light solarized colour scheme for gvim
    set background=light
    colorscheme solarized
    " Make the window a bit taller
    set columns=80
    set lines=45
    " Kill toolbar
    set guioptions-=T
    " Kill scrollbars
    set guioptions-=L
    set guioptions-=r
    " Add a menu option for reloading the vimrc
    menu File.Reload\ Configuration :source ~/.vimrc<CR>:filetype detect<CR>
    " Set a pretty font
    if s:uname == "Darwin"
        set gfn=Menlo\ For\ Powerline:h12
    else
        set guifont=Inconsolata\ 12
    endif
endif

" }}}

" Mappings ======================================================== {{{

let mapleader=','

" Make j and down keys move down one row even when lines are wrapped
nnoremap j gj
nnoremap <DOWN> gj
" Make k and up keys move up one row even when lines are wrapped
nnoremap k gk
nnoremap <UP> gk
" Make down key move down one row in insert mode even when lines are wrapped
inoremap <DOWN> <C-O>gj
" Make up key move up one row in insert mode even when lines are wrapped
inoremap <UP> <C-O>gk

inoremap jj <ESC>
inoremap kk <ESC>

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_

" Stay in visual mode after indenting
vnoremap < <gv
vnoremap > >gv

" Emacs-style start and end of line
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l
noremap <leader>v <c-w>v

" Make Y yank rest of line, like D and C
nnoremap Y y$

" Cut, copy and paste using the real clipboard
vnoremap <leader>y "+y
vnoremap <leader>x "+x
nnoremap <leader>p "+gp
nnoremap <leader>P "+gP

" Substitute
nnoremap <leader>s :%s//g<left><left>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Less chording
nnoremap ; :

" Quick return in insert mode
inoremap <c-cr> <esc>A<cr>
inoremap <s-cr> <esc>O

" Space toggles folds
nnoremap <space> za
vnoremap <space> za

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Switch tabs easily
if s:uname == "Darwin"
    nnoremap <D-S-left> gT
    nnoremap <D-S-right> gt
else
    nnoremap <A-S-left> gT
    nnoremap <A-S-right> gt
endif

" Fullscreen
if s:uname == "Darwin"
    noremap <D-Enter> :se invfullscreen<CR>
    inoremap <D-Enter> <ESC>:set invfullscreen<CR>a
else
    noremap <A-Enter> :se invfullscreen<CR>
    inoremap <A-Enter> <ESC>:set invfullscreen<CR>a
end

" Shortcuts for enabling / disabling search highlighting
nnoremap ,hl :set hls<CR>
nnoremap ,nhl :set nohls<CR>

" Use alt + {j,k} for moving lines up and down
if s:uname == "Darwin"
    nnoremap <D-j> :m+<CR>==
    nnoremap <D-k> :m-2<CR>==
    "inoremap <M-j> <Esc>:m+<CR>==gi
    "inoremap <M-k> <Esc>:m-2<CR>==gi
    vnoremap <D-j> :m'>+<CR>gv=gv
    vnoremap <D-k> :m-2<CR>gv=gv
else
    nnoremap <A-j> :m+<CR>==
    nnoremap <A-k> :m-2<CR>==
    "inoremap <A-j> <Esc>:m+<CR>==gi
    "inoremap <A-k> <Esc>:m-2<CR>==gi
    vnoremap <A-j> :m'>+<CR>gv=gv
    vnoremap <A-k> :m-2<CR>gv=gv
endif

" Write files with sudo if opened without priviliedges
cmap w!! w !sudo tee % >/dev/null

" }}}

" Plugin Options ================================================== {{{

if s:uname == "Darwin"
    " Command-T -- open in new tab with Command-Enter
    let g:CommandTAcceptSelectionTabMap=['<D-CR>', '<C-t>']
endif

" Posh powerline glyphs
let g:Powerline_symbols = 'fancy'
" Don't let Rails status line conflict with powerline
let g:rails_statusline = 0

" Make delimate handle spacing better
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" }}}

" Autocommands ==================================================== {{{

" JSON support
au! BufRead,BufNewFile *.json setfiletype json

if has("autocmd")
    " Clean up whitespace on save
    autocmd BufWritePre * CleanWhitespace
    " Tell ruby files to use two spaces for indentation
    autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2 tabstop=4
    " Tell json files to use two spaces for indentation
    autocmd FileType json setlocal softtabstop=2 shiftwidth=2 tabstop=4
    " Tell javascript files to use two spaces for indentation
    autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2 tabstop=4
    " Tell coffeescript files to use two spaces for indentation
    autocmd FileType coffee setlocal softtabstop=2 shiftwidth=2 tabstop=4
    " Tell scala files to use two spaces for indentation
    autocmd FileType scala setlocal softtabstop=2 shiftwidth=2 tabstop=4
    " Makefiles use tabs only
    autocmd FileType make setlocal noexpandtab
    " Some types of files should wrap to 79 characters
    autocmd FileType tex setlocal textwidth=79
    autocmd FileType plaintex setlocal textwidth=79
    autocmd FileType latex setlocal textwidth=79
    autocmd FileType rst setlocal textwidth=79
    " Enable spell checking for latex and rst
    autocmd FileType tex setlocal spell spelllang=en_gb
    autocmd FileType plaintex setlocal spell spelllang=en_gb
    autocmd FileType latex setlocal spell spelllang=en_gb
    autocmd FileType rst setlocal spell spelllang=en_gb
    " Use pdflatex for compiling latex files
    autocmd FileType tex setlocal makeprg=pdflatex\ %
    " Don't do things like indent lines following lines that start with 'for'
    autocmd FileType tex setlocal nosmartindent
    autocmd FileType plaintex setlocal nosmartindent
    autocmd FileType latex setlocal nosmartindent
    " Enable omnicomplete for Python
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    " Auto compile coffeescript
    autocmd BufWritePost,FileWritePost *.coffee :silent !coffee -c <afile>

    " Enable Markdown support
    autocmd FileType markdown setlocal ai formatoptions=tcroqn2 comments=n:&gt;
    autocmd FileType markdown setlocal nolist linebreak

    " Use {{{ - }}} style folds in vimscript
    autocmd FileType vim setlocal foldmethod=marker
endif

" }}}

" Misc ============================================================ {{{

" Remove trailing whitespace
function! <SID>CleanWhitespace()
    " Preparation - save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command CleanWhitespace call <SID>CleanWhitespace()


" Source a global configuration file if available
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" }}}

