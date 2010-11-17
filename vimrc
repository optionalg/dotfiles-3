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

" Special options for gvim (instead of in .gvimrc)
if has("gui_running")
    map <UP> i
    " Dark colour scheme for gvim
    colorscheme desert
    " Make the window a bit taller
    set columns=80
    set lines=45
    " Add a menu option for reloading the vimrc
    menu File.Reload\ Configuration :source ~/.vimrc<CR>:filetype detect<CR>
    " Set a pretty font
    set guifont=Inconsolata\ 12
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

" Cut, copy and paste using the real clipboard
vmap <leader>y "+y
vmap <leader>x "+x
nmap <leader>p "+gp
nmap <leader>P "+gP

" Write files with sudo if opened without priviliedges
cmap w!! w !sudo tee % >/dev/null

" Switch tabs easily
nmap <silent><A-left> gT
nmap <silent><A-right> gt

" NERDTree
map <F3> :NERDTreeToggle<CR>

" Shortcuts for enabling / disabling search highlighting
nmap ,hl :set hls<CR>
nmap ,nhl :set nohls<CR>

" Enable filetype settings (inc. indentation), files in .vim/ftplugin are read
" (force reload for pathogen)
filetype off
filetype plugin indent on

if has("autocmd")
    " Tell ruby files to use two spaces for indentation
    autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2 tabstop=4
    " Tell javascript files to use two spaces for indentation
    autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2 tabstop=4
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
endif

augroup mkd
    " Enable Markdown support
    autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
augroup end
