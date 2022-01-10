" default.vim - Better vim than the default
" Maintainer:   Liu-Cheng Xu <https://github.com/liuchengxu>
" Version:      1.0
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

if &compatible || exists('g:loaded_vim_better_default')
   finish
endif
let g:loaded_vim_better_default = 1

let s:save_cpo = &cpo
set cpo&vim

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Neovim has set these as default
if !has('nvim')

  set nocompatible

  syntax on                      " Syntax highlighting
  set synmaxcol=200              " Only highlight the first 200 columns.
  filetype plugin indent on      " Automatically detect file types
  set autoindent                 " Indent at the same level of the previous line
  set autoread                   " Automatically read a file changed outside of vim
  set backspace=indent,eol,start " Backspace for dummies
  set complete-=i                " Exclude files completion
  set display=lastline           " Show as much as possible of the last line
  set encoding=utf-8             " Set default encoding
  set history=10000              " Maximum history record
  set hlsearch                   " Highlight search terms
  set incsearch                  " Find as you type search
  set laststatus=2               " Always show status line
  set smarttab                   " Smart tab
  set lazyredraw                 " Only redraw when necessary.
  set ttyfast                    " Faster redrawing
  set viminfo+=!                 " Viminfo include !
  set wildmenu                   " Show list instead of just completing
  " In many terminal emulators the mouse works just fine.  By enabling it you
  " can position the cursor, Visually select and scroll with the mouse.
  " Only xterm can grab the mouse events when using the shift key, for other
  " terminals use ":", select text and press Esc.
  if has ('mouse')
    if &term =~ 'xterm'
      set mouse-=a
    else
      set mouse=nvi
    endif
  endif


endif

set shortmess=atOI " No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
set ignorecase     " Case insensitive search
set smartcase      " ... but case sensitive when uc present
set scrolljump=5   " Line to scroll when cursor leaves screen
set scrolloff=3    " Minumum lines to keep above and below cursor
set nowrap         " Do not wrap long lines
set shiftwidth=4   " Use indents of 4 spaces
set tabstop=4      " An indentation every four columns
set softtabstop=4  " Let backspace delete indent
set shiftround     " >> indents to next multiple of 'shiftwidth'.
set splitright     " Puts new vsplit windows to the right of the current
set splitbelow     " Puts new split windows to the bottom of the current
set autowrite      " Automatically write a file when leaving a modified buffer
set mousehide      " Hide the mouse cursor while typing
set hidden         " Allow buffer switching without saving
" set t_Co=256       " Use 256 colors
set ruler          " Show the ruler
set showcmd        " Show partial commands in status line and Selected characters/lines in visual mode
set showmode       " Show current mode in command-line
set showmatch      " Show matching brackets/parentthesis
set matchtime=5    " Show matching time
set report=0       " Always report changed lines
set linespace=0    " No extra spaces between rows
set pumheight=20   " Avoid the pop up menu occupying the whole screen
" set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries

if !exists('g:vim_better_default_tabs_as_spaces') || g:vim_better_default_tabs_as_spaces
  set expandtab    " Tabs are spaces, not tabs
end

" http://stackoverflow.com/questions/6427650/vim-in-tmux-background-color-changes-when-paging/15095377#15095377
set t_ut=

" tab和其他符号设置可见
" set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶
if has('multi_byte') && &encoding ==# 'utf-8'
  set list lcs =tab:>-,eol:¬,nbsp:±,trail:-,extends:→,precedes:←
  set showbreak=⌙
else
  set list lcs =tab:▶\ ,eol:↩,nbsp:‡,trail:◥,extends:▶,precedes:◀
  set showbreak=↪
endif
hi NonText ctermfg=18 guifg=#4a4a59
hi SpecialKey ctermfg=18 guifg=#4a4a59
"""""""""""""""""""""""""

set winminheight=0
set wildmode=list:longest,full
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null


if get(g:, 'vim_better_default_minimum', 0)
  finish
endif

if get(g:, 'vim_better_default_backup_on', 0)
  set backup
  set backupext=-vmbk
  set backupskip=
  set updatecount=100
else
  set nobackup
  set noswapfile
  set nowritebackup
endif

if get(g:, 'vim_better_default_enable_folding', 1)
  set foldenable
  set foldmarker={,}
  set foldlevel=0
  set foldmethod=marker
  " set foldcolumn=3
  set foldlevelstart=99
endif

" set cursorline              " Highlight current line
set fileformats=unix,dos,mac        " Use Unix as the standard file type
set number                  " Line numbers on
set relativenumber          " Relative numbers on
set fillchars=stl:\ ,stlnc:\ ,fold:\ ,vert:│

" Annoying temporary files
set directory=$HOME/.vim/swap/
set backupdir=$HOME/.vim/backup/
set viminfo=<100,'100,/50,:50,h,r$TEMP:,s10,n$HOME/.vim/viminfo
if v:version >= 703
  set undodir=$HOME/.vim/undo/
endif

highlight clear SignColumn  " SignColumn should match background
" highlight clear LineNr      " Current line number row will have same background color in relative mode

"设置vim的剪贴板和系统剪贴板同步
if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif

if get(g:, 'vim_better_default_persistent_undo', 0)
  if has('persistent_undo')
    set undofile             " Persistent undo
    set undolevels=1000      " Maximum number of changes that can be undone
    set undoreload=10000     " Maximum number lines to save for undo on a buffer reload
  endif
endif

if has('gui_running')
  set guioptions-=r        " Hide the right scrollbar
  set guioptions-=L        " Hide the left scrollbar
  set guioptions-=T
  set guioptions-=e
  set shortmess+=c
  " No annoying sound on errors
  set noerrorbells
  set novisualbell
  set visualbell t_vb=
endif

" Key (re)Mappings {

  if get(g:, 'vim_better_default_key_mapping', 1)

    " Basic {
      if get(g:, 'vim_better_default_basic_key_mapping', 1)
        " Add <slient> for the rhs is Ex-cmd as some GUI app, e.g., gnvim,
        " flashes when you use these mappings.
        " Move to the start of line
        nnoremap H ^
        " Move to the end of line
        nnoremap L $
       " Insert mode cursor movement
        inoremap <C-h> <S-Left>
        inoremap <C-l> <S-Right>
        inoremap <C-j> <Down>
        inoremap <C-k> <Up>
        inoremap <C-a> <Home>
        inoremap <C-e> <End>
        " Command mode cursor movement
        cnoremap <C-j> <Down>
        cnoremap <C-k> <Up>
        cnoremap <C-h> <Left>
        cnoremap <C-l> <Right>
        cnoremap <C-a> <Home>
        cnoremap <C-e> <End>
        " Quick command mode
        " nnoremap <CR> :
        " In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there.
        " autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

        " Search result highlight countermand,取消一直搜索高亮
        nnoremap <silent> <Leader>sc :nohlsearch<CR>
        " Toggle pastemode,取消粘贴时的自动缩进,用来减少粘贴时多出的注释符号
        nnoremap <silent> <Leader>tp :setlocal paste!<CR>
      endif
    " }

    " Buffer {
      if get(g:, 'vim_better_default_buffer_key_mapping', 1)
        nnoremap <silent> <Leader>bp :bprevious<CR>
        nnoremap <silent> <Leader>bn :bnext<CR>
        nnoremap <silent> <Leader>bf :bfirst<CR>
        nnoremap <silent> <Leader>bl :blast<CR>
        nnoremap <silent> <Leader>bd :bd<CR>
        nnoremap <silent> <Leader>bk :bw<CR>
      endif
    " }

    " File {
      if get(g:, 'vim_better_default_file_key_mapping', 1)
        " File save
        nnoremap <silent> <Leader>fs :update<CR>
      endif
    " }

    " Fold {
      if get(g:, 'vim_better_default_fold_key_mapping', 1)
        nnoremap <silent> <Leader>f0 :set foldlevel=0<CR>
        nnoremap <silent> <Leader>f1 :set foldlevel=1<CR>
        nnoremap <silent> <Leader>f2 :set foldlevel=2<CR>
        nnoremap <silent> <Leader>f3 :set foldlevel=3<CR>
        nnoremap <silent> <Leader>f4 :set foldlevel=4<CR>
        nnoremap <silent> <Leader>f5 :set foldlevel=5<CR>
        nnoremap <silent> <Leader>f6 :set foldlevel=6<CR>
        nnoremap <silent> <Leader>f7 :set foldlevel=7<CR>
        nnoremap <silent> <Leader>f8 :set foldlevel=8<CR>
        nnoremap <silent> <Leader>f9 :set foldlevel=9<CR>
      endif
    " }

    " Window {
      if get(g:, 'vim_better_default_window_key_mapping', 1)
        nnoremap <Leader>ww <C-W>w
        nnoremap <Leader>wr <C-W>r
        nnoremap <Leader>wd <C-W>c
        nnoremap <Leader>wq <C-W>q
        nnoremap <Leader>wj <C-W>j
        nnoremap <Leader>wk <C-W>k
        nnoremap <Leader>wh <C-W>h
        nnoremap <Leader>wl <C-W>l
        if has('nvim') || has('terminal')
          tnoremap <Leader>wj <C-W>j
          tnoremap <Leader>wk <C-W>k
          tnoremap <Leader>wh <C-W>h
          tnoremap <Leader>wl <C-W>l
        endif
        nnoremap <Leader>wH <C-W>5<
        nnoremap <Leader>wL <C-W>5>
        nnoremap <Leader>wJ :resize +5<CR>
        nnoremap <Leader>wK :resize -5<CR>
        nnoremap <Leader>w= <C-W>=
        nnoremap <Leader>ws <C-W>s
        nnoremap <Leader>w- <C-W>s
        nnoremap <Leader>wv <C-W>v
        nnoremap <Leader>w\| <C-W>v
        nnoremap <Leader>w2 <C-W>v
      endif
    " }

  endif

" }

let &cpo = s:save_cpo
unlet s:save_cpo
