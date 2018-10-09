set nocompatible              " be iMproved, required
filetype off                  " required

" To install Plugins, launch vim and run :PluginInstall
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin("/vim/vimfiles/plugin")
" call vundle#rc("/vim/vimfiles/plugin")

" To view/edit vimrc :e $MYVIMRC
" To increase decrease the height width of Vim use :set lines=35 columns=150

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'jadejs/jade'
Plugin 'chase/vim-ansible-yaml'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'szw/vim-ctrlspace'
Plugin 'Konfekt/FastFold'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'leafgarland/typescript-vim' "Provides syntax highlighting and a method to compile your typescript to vanilla javascript.
Plugin 'Quramy/tsuquyomi' " A client for TSServer
Plugin 'Shougo/vimproc.vim' "An asynchronous process manager
Plugin 'Valloric/YouCompleteMe' " A fast, as-you-type, fuzzy-search code completion engine
" Plugin 'ternjs/tern_for_vim' " YouCompleteMe needs it
Plugin 'icholy/typescript-tools.git'
Plugin 'Shutnik/jshint2.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tomtom/tcomment_vim' " https://github.com/tomtom/tcomment_vim
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'burnettk/vim-angular'
Plugin 'majutsushi/tagbar'
Plugin 'ternjs/tern_for_vim' "In JavaScript files, the package will hook into omni completion to handle autocompletion
Plugin 'maralla/completor.vim' "Autocomplete

call vundle#end()                   " required
filetype plugin indent on           " required

"Plugin Syntastic config
"npm install -g eslint
let g:syntastic_javascript_checkers = ['eslint']
let g:minimap_highlight='Visual'

"othree/javascript-libraries-syntax.vim      Setup Vim for following libraries
let g:used_javascript_libs = 'angularjs,angularui,underscore,backbone'

"Install typescript-tools
"npm install -g typescript-tools

"Use YouCompleteMe to have omni-completion automatically.
"if !exists(“g:ycm_semantic_triggers”)
 "let g:ycm_semantic_triggers = {}
 "endif
 "let g:ycm_semantic_triggers[‘typescript’] = [‘.’]


" hide unsaved files and allow switching to other buffers
set hidden

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      ret eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

au GUIEnter * simalt ~x

set guioptions-=l 
set guioptions-=L 
set guioptions-=r 
set guioptions-=R 
set guioptions-=T

set lines=99999
set columns=99999

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Courier\ New\ 11
  elseif has("gui_photon")
    set guifont=Courier\ New:s11
  elseif has("gui_kde")
    set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    set guifont=Courier_New:h11:cDEFAULT
  endif
endif

"whenever a file is open (whether from NERDTree or otherwise), automatically cd to the path containing the file.
set autochdir

"Auto-Reload Your Vimrc
augroup reload_vimrc
autocmd!
autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"Show line number
set number

"Open files always in new tabs
"autocmd VimEnter * tab all
"autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

"Set working directory to the location of current file.
set autochdir

"Move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
"Add/Remove a widget
":set guioptions-=m  "remove menu bar
":set guioptions-=T  "remove toolbar
":set guioptions-=r  "remove right-hand scroll bar
":set guioptions-=L  "remove left-hand scroll bar
":set go+=m          "add menu bar, 'go' is an abbreviation for 'guioptions'

"Press F8 to toggle Tagbar
nmap <F8> :TagbarToggle<CR>

" highlightt the current line number
highlight CursorLineNR guifg=#ffffff ctermfg=15
colorscheme delek

" YouCompleteMe
set encoding=utf-8

"Bind autocomplete to TAB such that you still get TAB unless you are at the end of a word to complete. It's super convenient.
    function! InsertTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
      else
        return "\<c-p>"
      endif
    endfunction
    inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"TypeScript
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
