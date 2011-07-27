" Pathogen support
call pathogen#runtime_append_all_bundles()

" Enable syntax highlighting
syntax enable
" Use indent level from previous line
set autoindent
" As above, but recognises code syntax to do it more intelligently
"set smartindent
"set cindent
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
set scrolloff=2
" Use the mouse in terminal emulators that support it
set mouse=a
" Only use one space when joining lines
set nojoinspaces
" Up the undo / redo limit
set history=1000
" Show options during tab completion
set wildmenu

" Set a colour scheme
colorscheme zellner

set backup " make backup files
set backupdir=~/.vim/backup " location of backup files
set swapfile " make swap files
set directory=~/.vim/tmp " location of swap files

" Special options for gvim (instead of in .gvimrc)
let s:uname = system("echo -n \"$(uname)\"")

if s:uname == "Darwin"
    colorscheme molokai
endif

if has("gui_running")
    map <UP> i
    " Dark colour scheme for gvim
    "colorscheme desert
    colorscheme molokai
    " Make the window a bit taller
    set columns=80
    set lines=45
    " Kill toolbar
    set guioptions-=T
    " Add a menu option for reloading the vimrc
    menu File.Reload\ Configuration :source ~/.vimrc<CR>:filetype detect<CR>
    " Set a pretty font
    if s:uname == "Darwin"
        set gfn=Menlo\ Regular:h12
    else
        set guifont=Inconsolata\ 12
    endif
endif

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

" Make Y yank rest of line, like D and C
nnoremap Y y$

" Cut, copy and paste using the real clipboard
vmap <leader>y "+y
vmap <leader>x "+x
nmap <leader>p "+gp
nmap <leader>P "+gP

" Write files with sudo if opened without priviliedges
cmap w!! w !sudo tee % >/dev/null

" Switch tabs easily
if s:uname == "Darwin"
    nnoremap <D-S-left> gT
    nnoremap <D-S-right> gt
else
    nnoremap <A-S-left> gT
    nnoremap <A-S-right> gt
endif

" Easy access to NERDTree
map <F3> :NERDTreeToggle<CR>

" Shortcuts for enabling / disabling search highlighting
nmap ,hl :set hls<CR>
nmap ,nhl :set nohls<CR>

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

if s:uname == "Darwin"
    " Command-T -- open in new tab with Command-Enter
    let g:CommandTAcceptSelectionTabMap=['<D-CR>', '<C-t>']
endif

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,trail:•

" Remove trailing whitespace
command CleanWhitespace %s/\s\+$//

set wildignore+=*.o,*.obj,.git,*.pyc

" Enable filetype settings (inc. indentation), files in .vim/ftplugin are read
" (force reload for pathogen)
filetype off
filetype plugin indent on

" Highlight 80th column so code can still be pretty in full-screen terminals
if exists("&colorcolumn")
    set colorcolumn=81
    hi ColorColumn guibg=#282828 ctermbg=235
endif

" JSON support
au! BufRead,BufNewFile *.json setfiletype json

if has("autocmd")
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
endif

augroup mkd
    " Enable Markdown support
    autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
augroup end

" Source a global configuration file if available
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

