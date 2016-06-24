" Vim config
" Mainly stolen from spf13 config
" vim: set sw=4 ts=4 sts=4 et tw=80 foldmarker={,} foldlevel=0 foldmethod=marker:

set nocompatible        " Must be first line

" Vundle install {
    filetype off                  " required
    set rtp+=~/.vim/bundle/Vundle.vim
" }

" Plugins install {
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    " Required
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'

    Plugin 'mileszs/ack.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'tacahiroy/ctrlp-funky'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'powerline/fonts'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-repeat'
    Plugin 'rhysd/conflict-marker.vim'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'matchit.zip'
    Plugin 'bling/vim-bufferline'
    Plugin 'flazz/vim-colorschemes'
    Plugin 'mbbill/undotree'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'mhinz/vim-signify'
    Plugin 'osyo-manga/vim-over'
    Plugin 'kana/vim-textobj-user'
    Plugin 'kana/vim-textobj-indent'
    Plugin 'gcmt/wildfire.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'godlygeek/tabular'
    Plugin 'luochen1990/rainbow'

    call vundle#end() 
" }

" Style {
    set t_Co=256
    set background=dark     " Assume a dark background
    colorscheme Tomorrow-Night-Eighties
" }

" General {
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    scriptencoding utf-8
" }

"Text formatting {
    set relativenumber
    set wrap
    set nospell
    set expandtab
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)

    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current

    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    " Max 80 chars per line
    set colorcolumn=81
"}

" Clipboard {
    " Share vim and system clipboard if possible
    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
" }

" Modifs history {
    set history=1000                    " Store a ton of history (default is 20)
    set nobackup                  " Disable backups and swapfiles
    set noswapfile
    if has('persistent_undo')
        set undofile                " Enable persistent undo
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif

    set undodir=~/.vimtmp
" }

" UI {
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing

    set tabpagemax=15               " Only show 15 tabs
    set noshowmode                  " Do not display the current mode (already covered by Airline)

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and

    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=1                " Lines to scroll when cursor leaves screen
    set scrolloff=10                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set foldmethod=syntax
    set foldlevelstart=20
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
" }

" Mappings {
    " Leader key definition
    let mapleader=","

    " Maps to make handling windows a bit easier
    set splitbelow
    set splitright
    noremap <silent> ,h :wincmd h<CR>
    noremap <silent> ,j :wincmd j<CR>
    noremap <silent> ,k :wincmd k<CR>
    noremap <silent> ,l :wincmd l<CR>
    noremap <silent> ,wc :close<CR>
    noremap <silent> ,wo <C-W>o
    noremap <silent> ,ml <C-W>L
    noremap <silent> ,mk <C-W>K
    noremap <silent> ,mh <C-W>H
    noremap <silent> ,mj <C-W>J

    " Edit the vimrc file
    nmap <silent> ,ev :e $MYVIMRC<CR>
    nmap <silent> ,sv :so $MYVIMRC<CR>:AirlineRefresh<CR>

    " Remap jj to esc
    imap jj <esc>
    imap kk <esc>
    cmap jj <esc>
    cmap kk <esc>

    " Remap j and k to navigate in a long wrapped line display in two in the
    " editor
    nnoremap j gj
    nnoremap k gk

    " Bubble single lines (kicks butt)
    " http://vimcasts.org/episodes/bubbling-text/
    nmap <C-Up> ddkP
    nmap <C-Down> ddp

    " Bubble multiple lines
    vmap <C-Up> xkP`[V`]
    vmap <C-Down> xp`[V`]

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h<CR>
    cmap cd. lcd %:p:h<CR>

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Saves file when Vim window loses focus
    au FocusLost * :wa

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Autoindent the whole file
    map <leader>i mzgg=G`z

    " Marks shortcuts
    map <Leader>m :marks<CR>

    " Remove highlight search
    map <C-l> <C-l>:nohl<CR>
" }

" Plugins {
    " Airline {
        let g:airline_powerline_fonts=1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme='murmur'
    " }

    " NERDTree {
        map <C-e> <plug>NERDTreeTabsToggle<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " Ctrlp {
        let g:ctrlp_working_path_mode = 0
        let g:ctrlp_extensions = ['funky']
        nnoremap <Leader>fu :CtrlPFunky<Cr>
        nnoremap <Leader>b  :CtrlPBuffer<CR>
        let g:ctrlp_show_hidden = 1
    " }

    " Indent guides {
        let g:indent_guides_enable_on_vim_startup = 0
    " }

    " Enable rainbow parenthesis {
        let g:rainbow_active = 1
    " }

    " Tabularize {
        nmap <Leader>t& :Tabularize /&<CR>
        vmap <Leader>t& :Tabularize /&<CR>

        nmap <Leader>t= :Tabularize /^[^=]*\zs=<CR>
        vmap <Leader>t= :Tabularize /^[^=]*\zs=<CR>

        nmap <Leader>t=> :Tabularize /=><CR>
        vmap <Leader>t=> :Tabularize /=><CR>

        nmap <Leader>t: :Tabularize /:<CR>
        vmap <Leader>t: :Tabularize /:<CR>

        nmap <Leader>t:: :Tabularize /:\zs<CR>
        vmap <Leader>t:: :Tabularize /:\zs<CR>

        nmap <Leader>t, :Tabularize /,<CR>
        vmap <Leader>t, :Tabularize /,<CR>

        nmap <Leader>t,, :Tabularize /,\zs<CR>
        vmap <Leader>t,, :Tabularize /,\zs<CR>
        nmap <Leader>t<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>t<Bar> :Tabularize /<Bar><CR>
    " }

    " Ack {
        nnoremap <leader>a :Ack 
    " }

    " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " OverCommandLine {
        nnoremap <Leader>o :OverCommandLine<CR>
        vnoremap <Leader>o :OverCommandLine<CR>
    " }
" }

" Helper functions {
    " Highlight EOL whitespace,
    " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    " highlight ExtraWhitespace ctermbg=darkred guibg=#382424
    " autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    " autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    " " the above flashes annoyingly while typing, be calmer in insert mode
    " autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    " autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

    function! s:FixWhitespace(line1,line2)
        let l:save_cursor = getpos(".")
        silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
        call setpos('.', l:save_cursor)
    endfunction

    " Run :FixWhitespace to remove end of line white space.
    command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)"
" }

" Use local config if present {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
