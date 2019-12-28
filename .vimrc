"
" Setup folder structure
"
if !isdirectory(expand('~/.vim/undo/', 1))
    silent call mkdir(expand('~/.vim/undo', 1), 'p')
endif

if !isdirectory(expand('~/.vim/backup/', 1))
    silent call mkdir(expand('~/.vim/backup', 1), 'p')
endif

if !isdirectory(expand('~/.vim/swap/', 1))
    silent call mkdir(expand('~/.vim/swap', 1), 'p')
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has("nvim")
call plug#begin('~/.local/share/nvim/plugged')
else
call plug#begin('~/.vim/plugged')
end
  Plug 'tpope/vim-surround'

  Plug 'airblade/vim-gitgutter'

  Plug 'bling/vim-airline'
    " Airline options
    let g:airline#extensions#branch#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#tabline#enabled = 1

  " Enable completion where available.
  " This setting must be set before ALE is loaded.
  "
  " You should not turn this setting on if you wish to use ALE as a completion
  " source for other completion plugins, like Deoplete.
  " let g:ale_completion_enabled = 1
  let g:ale_set_balloons = 1
  if has('nvim') || v:version > 800
    Plug 'w0rp/ale'
      " Gutter always open
      let g:ale_sign_column_always = 1
      let g:ale_sign_warning = "◉"
      let g:ale_sign_error = "◉"
      let g:ale_rust_rls_config = {'rust': {'clippy_preference': 'on'}}
      " let g:ale_rust_cargo_use_clippy = 1
      let g:ale_linters = {
                  \ 'rust': [ 'rls' ],
                  \ }
      nnoremap gd :ALEGoToDefinition<cr>
  endif

  Plug 'junegunn/vim-easy-align'
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

  Plug 'terryma/vim-multiple-cursors'
    let g:multi_cursor_exit_from_insert_mode = 0

  Plug 'kien/rainbow_parentheses.vim'
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

  " Plug 'jiangmiao/auto-pairs'
  "   let g:AutoPairsMultilineClose = 0

  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

  Plug 'andrewradev/vim-eco'

  Plug 'tpope/vim-fugitive'
    augroup fugitive_ext
      autocmd!
      " Browse to the commit under my cursor
      autocmd FileType fugitiveblame nnoremap <buffer> gb :execute ":Gbrowse " . expand("<cword>")<cr>
    augroup END
    nmap <C-b> :Gblame<cr>

  " :Gbrowse from fugitive.vim to open GitHub URLs
  Plug 'tpope/vim-rhubarb'

  Plug 'tpope/vim-unimpaired'

  Plug 'morhetz/gruvbox'

  Plug 'tpope/vim-commentary'

  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
    runtime macros/matchit.vim

  Plug 'ctrlpvim/ctrlp.vim'
    " modifier to "r": start search from the cwd instead of the current file's directory
    let g:ctrlp_working_path_mode = 'w'
    if executable('rg')
      let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
      let g:ctrlp_use_caching = 0
    endif
    " if executable('ag')
    "   let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden -g ""'
    "   let g:ctrlp_use_caching = 0
    " endif

  Plug 'jremmen/vim-ripgrep'

  Plug 'AndrewRadev/splitjoin.vim'

  " Plug 'tpope/vim-vinegar'
  "   let g:netrw_winsize = 20

  Plug 'rust-lang/rust.vim'

  " Plug 'racer-rust/vim-racer'
    " au FileType rust nmap gd <Plug>(rust-def)

  Plug 'easymotion/vim-easymotion'

  Plug 'elixir-editors/vim-elixir'

  Plug 'leafgarland/typescript-vim'
  Plug 'MaxMEllon/vim-jsx-pretty'
    highlight def link jsxTag xmlTag
    highlight def link jsxTagName xmlTagName
    highlight def link jsxComponentName xmlTagName
    highlight def link jsxAttrib htmlArg
    highlight def link jsxOpenPunct xmlTag
    highlight def link jsxCloseString jsxOpenPunct

  Plug 'justinmk/vim-dirvish'
    let g:dirvish_mode = ':sort ,^.*[\/],'

  Plug 'zxqfl/tabnine-vim'
call plug#end()

" We're running Vim, not Vi!
set nocompatible

" Enable syntax highlighting
if !exists('g:syntax_on')
  syntax on
endif

" Enable filetype detection
filetype on

" Enable filetype-specific indenting
filetype indent on

" Enable filetype-specific plugins
filetype plugin on

" Don't jump to beginning of the line when switching buffers
set nostartofline

" Yanks go on clipboard instead.
set clipboard=unnamed

" Show line numbers
set number

" Set relative line numbers
set relativenumber

" Show statusline
set laststatus=2

" Case-insensitive search
set ignorecase

" Highlight search results
set hlsearch

" Set the default tabstop
set tabstop=2
set softtabstop=2

set scrolloff=7

" Set the default shift width for indents
set shiftwidth=2

" Make tabs into spaces (set by tabstop)
set expandtab

" Smarter tab levels
set smarttab

set hidden

" Use backups
" Source:
"   http://stackoverflow.com/a/15317146
set backup
set writebackup
set backupdir=~/.vim/backup//

" Use a specified swap folder
" Source:
"   http://stackoverflow.com/a/15317146
set directory=~/.vim/swap//

" Disable beeping and flashing.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Automatically re-read the file if it has changed
set autoread

" Default to Unix LF line endings
set ffs=unix

set incsearch

" . To search relative to the directory of the current file
" ,, To search in the current directory
set path=.,,

if has("patch-7.4.710")
  set list
  set listchars=space:·
end

if has("termguicolors")
  set termguicolors
endif

let macvim_skip_colorscheme=1
set background=dark
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox
highlight Whitespace guifg='#504945'
match Whitespace /\s\+/
if has("gui_macvim")
  set macligatures
end
set guifont=Fira\ Code\ Retina:h12

set linespace=4
set cursorline

set completeopt=menu,menuone,preview,noselect,noinsert

let g:updatetime=250
set updatetime=250

" let mapleader='\'
let mapleader=' '
nnoremap <space> <nop>

nnoremap <leader>p :CtrlPBufTag<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" No scroll bar in GUI
if has('gui_running')
  set guioptions-=r
end

" Nice window title
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                                              " file name
    set titlestring+=%h%m%r%w                                         " flags
    set titlestring+=\ -\ %{v:progname}                               " program name
endif

" New Lines at Insert Mode
imap <S-D-CR> <Esc>O
imap <S-CR> <Esc>o

" Close current buffer but not split
nmap <leader>q :bp <BAR> bd #<cr>

" Hide search highlight on double Esc
nmap <Esc><Esc> :nohl<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Yank current file path
nnoremap yp :let @*=expand("%")<CR>:echo "Yanked \"".@*."\""<CR>

" Trim whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" set omnifunc=ale#completion#OmniFunc
autocmd FileType ruby setlocal omnifunc=ale#completion#OmniFunc
