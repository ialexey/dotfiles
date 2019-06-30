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

if has("mac")
" Python Setting {
  set pythondll=/usr/local/Frameworks/Python.framework/Versions/3.7/Python
  set pythonhome=/usr/local/Frameworks/Python.framework/Versions/3.7
  set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/3.7/Python
  set pythonthreehome=/usr/local/Frameworks/Python.framework/Versions/3.7
  " }
end

call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-surround'

  if has("mac")
    if has('nvim')
      Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Plug 'Shougo/defx.nvim'
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
    endif
    autocmd FileType defx call s:defx_my_settings()
    function! s:defx_my_settings() abort
      " Define mappings
      nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
      nnoremap <silent><buffer><expr> c defx#do_action('copy')
      nnoremap <silent><buffer><expr> m defx#do_action('move')
      nnoremap <silent><buffer><expr> p defx#do_action('paste')
      nnoremap <silent><buffer><expr> l defx#do_action('open')
      nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
      nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
      nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
      nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
      nnoremap <silent><buffer><expr> N defx#do_action('new_file')
      nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
      nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
      nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
      nnoremap <silent><buffer><expr> d defx#do_action('remove')
      nnoremap <silent><buffer><expr> r defx#do_action('rename')
      nnoremap <silent><buffer><expr> !  defx#do_action('execute_command')
      nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
      nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
      nnoremap <silent><buffer><expr> .  defx#do_action('toggle_ignored_files')
      nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
      nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
      nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
      nnoremap <silent><buffer><expr> - defx#do_action('cd', [getcwd()])
      nnoremap <silent><buffer><expr> q defx#do_action('quit')
      nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
      nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
      nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
      nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
      nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
      nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
      nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
      " open file in split and do not close defx
      nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')
    endfunction
    " Open defx
    nnoremap ,d :Defx -split=vertical -winwidth=41 -direction=topleft <cr>
    " Reveal current file
    nnoremap ,r :Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>zz<C-w>W
    autocmd FileType defx setlocal relativenumber
    " make sure vim does not open files and other buffers on defx window
    autocmd BufEnter * if bufname('#') =~# "defx" && winnr('$') > 1 | b# | endif
  end

  if has("mac")
    let g:coc_node_path=expand("~/.nvm/versions/node/v8.10.0/bin/node")
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  end

  Plug 'airblade/vim-gitgutter'

  Plug 'bling/vim-airline'
    " Airline options
    let g:airline#extensions#branch#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#coc#enabled = 1

  if has('nvim') || v:version > 800
    Plug 'w0rp/ale'
      " Gutter always open
      let g:ale_sign_column_always = 1
      let g:ale_sign_warning = "◉"
      let g:ale_sign_error = "◉"
      let g:ale_set_balloons = 1
  endif

  Plug 'junegunn/vim-easy-align'
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

  Plug 'terryma/vim-multiple-cursors'
    let g:multi_cursor_exit_from_insert_mode = 0

  if has("mac")
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    map <Leader>t :FZF<cr>
    map <Leader>b :Buffers<cr>
    " Tags in the current buffer
    map <Leader>r :BTags<cr>
    map <Leader>R :Tags<cr>
    map <Leader>l :BLines<cr>
    map <Leader>a :Ag<cr>
    " Preview Ag
    command! -bang -nargs=* Ag
          \ call fzf#vim#ag(<q-args>,
          \                 <bang>0 ? fzf#vim#with_preview('up:60%')
          \                         : fzf#vim#with_preview('right:50%'),
          \                 <bang>0)
    " Likewise, FZF / Files command with preview window
    command! -bang -nargs=* FZF
          \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
  end

  Plug 'kien/rainbow_parentheses.vim'
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

  Plug 'tmsvg/pear-tree'
  let g:pear_tree_smart_openers = 1
  let g:pear_tree_smart_closers = 1
  let g:pear_tree_smart_backspace = 1

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

  Plug 'morhetz/gruvbox'

  Plug 'scrooloose/nerdcommenter'
    " Add spaces after comment
    let g:NERDSpaceDelims = 1

    " Align all comments to the left  when multiline
    let g:NERDDefaultAlign = 'left'

    let g:NERDCommentEmptyLines = 1

  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
    runtime macros/matchit.vim

call plug#end()

" We're running Vim, not Vi!
set nocompatible

" Enable syntax highlighting
syntax on

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

if has("patch-7.4.710")
  set list
  set listchars=space:·
end

let macvim_skip_colorscheme=1
set background=dark
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox
if has("gui_macvim")
  set macligatures
end
set guifont=Fira\ Code\ Retina:h12

set linespace=4
set cursorline

set completeopt=menu,menuone,preview,noinsert

let mapleader='\'

" New Lines at Insert Mode
imap <S-D-CR> <Esc>O
imap <S-CR> <Esc>o

" New Lines at Normal Mode (Alt-O, Alt-o)
nmap Ø O<Esc>
nmap ø o<Esc>

" Use <c-space> to trigger completion.
inoremap <silent> <c-space> <C-n>

" Tab as down arrow when completion menu is visible
inoremap <expr> <TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<Up>" : "\<TAB>"

" Escape to close completion menu
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

nmap gd <Plug>(coc-definition)

" Close current buffer but not split
nmap <leader>q :bp <BAR> bd #<cr>

" Hide search highlight on double Esc
nmap <Esc><Esc> :nohl<cr>

" Tab / Shift-Tab for next / prev buffer
noremap <Tab> :bn<cr>
noremap <S-Tab> :bp<cr>

" Cmd-1, Cmd-2, ... for 1st, 2nd, etc opened buffers (not buffer number)
noremap <D-1> :bfirst<CR>
noremap <D-2> :bfirst<CR>:bn<CR>
noremap <D-3> :bfirst<CR>:2bn<CR>
noremap <D-4> :bfirst<CR>:3bn<CR>
noremap <D-5> :bfirst<CR>:4bn<CR>
noremap <D-6> :bfirst<CR>:5bn<CR>
noremap <D-8> :bfirst<CR>:6bn<CR>
noremap <D-9> :bfirst<CR>:7bn<CR>
noremap <D-0> :bfirst<CR>:8bn<CR>

" Trim whitespace on save
autocmd BufWritePre * %s/\s\+$//e
