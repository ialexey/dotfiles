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
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvimdev/indentmini.nvim'

  Plug 'nvim-lua/plenary.nvim'

  Plug 'mikavilpas/yazi.nvim'

  " Avante
  " Deps
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'stevearc/dressing.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'MeanderingProgrammer/render-markdown.nvim'

  " Optional deps
  Plug 'hrsh7th/nvim-cmp'
  Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
  Plug 'HakonHarnes/img-clip.nvim'
  Plug 'zbirenbaum/copilot.lua'

  " Yay, pass source=true if you want to build from source
  Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
  " Avante end
else
call plug#begin('~/.vim/plugged')
end
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'tpope/vim-surround'

  Plug 'airblade/vim-gitgutter'

  if !has("nvim")
    Plug 'bling/vim-airline'
    " Airline options
    let g:airline#extensions#branch#enabled = 0
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#hunks#enabled = 0
    function! AirlineInit()
      let g:airline_symbols.linenr = ''
      let g:airline_symbols.maxlinenr = ''
      let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', ':%v'])
    endfunction
    autocmd User AirlineAfterInit call AirlineInit()
  end

  Plug 'junegunn/vim-easy-align'
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

  Plug 'terryma/vim-multiple-cursors'

  " Plug 'kien/rainbow_parentheses.vim'
  "   au VimEnter * RainbowParenthesesToggle
  "   au Syntax * RainbowParenthesesLoadRound
  "   au Syntax * RainbowParenthesesLoadSquare
  "   au Syntax * RainbowParenthesesLoadBraces

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
    nmap <C-b> :Git blame<cr>

  " :Gbrowse from fugitive.vim to open GitHub URLs
  Plug 'tpope/vim-rhubarb'

  Plug 'tpope/vim-unimpaired'

  if !has("nvim")
    Plug 'morhetz/gruvbox'
  end

  Plug 'tpope/vim-commentary'

  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
    runtime macros/matchit.vim

  Plug 'ctrlpvim/ctrlp.vim'
    " modifier to "r": start search from the cwd instead of the current file's directory
    let g:ctrlp_working_path_mode = 'w'
    let g:ctrlp_switch_buffer = '0'
    let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
    if executable('rg')
      let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
      let g:ctrlp_use_caching = 0
    endif
    " if executable('ag')
    "   let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden -g ""'
    "   let g:ctrlp_use_caching = 0
    " endif
    let g:ctrlp_prompt_mappings = { 'PrtDeleteEnt()': ['<F2>'] }

  Plug 'jremmen/vim-ripgrep'

  Plug 'AndrewRadev/splitjoin.vim'

  Plug 'rust-lang/rust.vim'

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

  " Plug 'justinmk/vim-dirvish'
  "   let g:dirvish_mode = ':sort ,^.*[\/],'

  " Plug 'codota/tabnine-vim'
  Plug 'diepm/vim-rest-console'

  Plug 'christoomey/vim-tmux-navigator'

  " Plug 'Konfekt/FastFold'

  Plug 'vifm/vifm.vim'

  Plug 'dhruvasagar/vim-table-mode'

  Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}

  Plug 'sirtaj/vim-openscad'

  Plug 'stevearc/vim-arduino'

  Plug 'github/copilot.vim'
  imap <D-]> <Plug>(copilot-next)
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

set showcmd

" autocmd FileType c setlocal shiftwidth=4 tabstop=4 noexpandtab

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
  set listchars=tab:→-,space:·
end

if has("termguicolors")
  set termguicolors
endif

let macvim_skip_colorscheme=1
if !has("nvim")
  set background=dark
  let g:gruvbox_contrast_dark="hard"
  colorscheme gruvbox
  end
highlight Whitespace guifg='#504945'
match Whitespace /\s\+/

let g:terminal_ansi_colors = [
  \'#1d2021', '#fb4934', '#98971A', '#D79921',
  \'#83a598', '#B16286', '#689D6A', '#ebdbb2',
  \'#fb4934', '#b8bb26', '#fabd2f', '#83a598',
  \'#d3869b', '#8ec07c', '#fe8019', '#FBF1C7' ]

highlight Terminal guibg='#1d2021'
highlight Terminal guifg='#ebdbb2'

if has("gui_gtk3")
  set guioptions -=m " hide menu bar
  set guioptions -=T " hide toolbar
  set guioptions -=a " do not copy on visual selection
  " laptop
  " set guifont=Fira\ Code\ Retina\ 8.7
  " ultrafine
  set guifont=Fira\ Code\ Retina\ 9.5
end

if has("nvim")
  set guifont=Fira\ Code\ Retina:h9.5

  if exists("g:neovide")
    if empty($WAYLAND_DISPLAY)
      set guifont=Fira\ Code\ Retina:h9.5
    else
      set guifont=Fira\ Code\ Retina:h10.5
    end
  end
end

if has("gui_gtk3")|| has("nvim") " gvim
  set linespace=1
  set lazyredraw

  let g:netrw_browsex_viewer= "xdg-open"

  " Yanks go on clipboard instead.
  set clipboard=unnamed,unnamedplus
elseif has("gui_macvim")
  set macligatures
  set guifont=Fira\ Code\ Retina:h12
  set linespace=1

  " Yanks go on clipboard instead.
  set clipboard=unnamed

  set fu
end

set cursorline

set completeopt=menu,menuone,noselect,noinsert
if !has('nvim')
  set completeopt+=popup
end

let g:updatetime=250
set updatetime=250

set splitbelow
set splitright

set wildmenu

" let mapleader='\'
let mapleader=' '
nnoremap <space> <nop>

nnoremap <leader>p :<C-u>CocList outline<cr>
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

" set foldmethod=syntax
" set nofoldenable
" set foldlevel=100

set switchbuf=uselast "jump to the previously used window when jumping to errors with quickfix commands.

" New Lines at Insert Mode
imap <S-D-CR> <Esc>O
imap <S-CR> <Esc>o

" Close current buffer but not split
nmap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Hide search highlight on double Esc
nmap <Esc><Esc> :nohl<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Yank current file path
nnoremap yp :let @*=expand("%")<CR>:echo "Yanked \"".@*."\""<CR>

function GoToFileInExistingBuf()
  let mycurf=expand("<cfile>")
  wincmd p
  execute("e ".mycurf)
  " wincmd p
endfunction
" nnoremap gs :call GoToFileInExistingBuf()<cr>

function GoToDecl()
  let mycurf=expand("%")
  call CocAction('jumpDefinition')
  let declfile=expand("%")
  wincmd p
  execute("e ".declfile)
  wincmd p
  execute("e ".mycurf)
  wincmd p
endfunction

if (has("nvim"))
  nnoremap g/ :Yazi cwd<cr>
  nnoremap - :Yazi<cr>
else
  nnoremap g/ :Vifm .<cr>
  nnoremap - :Vifm<cr>
endif

" Trim whitespace on save
autocmd BufWritePre * if index(['mail'], &ft) < 0 | %s/\s\+$//e
autocmd BufWritePre * if index(['mail'], &ft) < 0 | %s///e

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gs :call GoToDecl()<cr>
nmap <leader>s :call CocActionAsync('showSignatureHelp')<cr>
nmap <leader>h :call CocActionAsync('doHover')<cr>

" compile and execute current C file
nmap <leader>r :!gcc -Wall %:t -o %:t:r && ./%:t:r<cr>

nmap <C-g> :vert G<cr>

inoremap jk <ESC>
vnoremap $ g_
nmap <leader>w :w<cr>

" paste without overwriting register
xnoremap p pgvy

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cursorline
  autocmd WinLeave * set nocursorline
augroup END

" COC
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
autocmd CursorHoldI * silent call CocActionAsync('doHover')

xmap <silent><leader>f :call CocAction('format') \| call CocAction('runCommand', 'editor.action.organizeImport')<cr>
nmap <silent><leader>f :call CocAction('format') \| call CocAction('runCommand', 'editor.action.organizeImport')<cr>

inoremap <silent><expr> <C-n>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<C-n>" :
      \ coc#refresh()
inoremap <expr><C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! MoveWindowToDirection(direction)
  let cur_win = win_getid()
  let cur_buf = bufnr('%')
  let cur_view = winsaveview()

  " Try to go to target window
  execute 'wincmd ' . a:direction
  let target_win = win_getid()

  if target_win == cur_win
    echo "No window in direction: " . a:direction
    return
  endif

  let target_buf = bufnr('%')
  let target_view = winsaveview()

  " Swap buffers
  execute 'buffer' cur_buf
  call winrestview(cur_view)

  call win_gotoid(cur_win)
  execute 'buffer' target_buf
  call winrestview(target_view)

  call win_gotoid(target_win)
endfunction

" Remap C-w H/J/K/L to swap splits like helix does
nnoremap <silent> <C-w>H :call MoveWindowToDirection('h')<CR>
nnoremap <silent> <C-w>J :call MoveWindowToDirection('j')<CR>
nnoremap <silent> <C-w>K :call MoveWindowToDirection('k')<CR>
nnoremap <silent> <C-w>L :call MoveWindowToDirection('l')<CR>
