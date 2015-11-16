set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin on GitHub repo
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'kchmck/vim-coffee-script'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'derekwyatt/vim-sbt'
Plugin 'derekwyatt/vim-scala'
Plugin 'sukima/xmledit'
Plugin 'tpope/vim-fugitive'
Plugin 'chriskempson/base16-vim'
Plugin 'tfnico/vim-gradle'
Plugin 'solarnz/thrift.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'rking/ag.vim'
Plugin 'x1a0/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" For multi-byte character support (CJK support, for example):
set fileencodings=utf-8,cp936,ucs-bom,big5,euc-jp,euc-kr,gb18030,latin1

set tabstop=2       " Number of spaces that a <Tab> in the file counts for.

set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.

set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set ignorecase      " Ignore case in search patterns.

set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).

"set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

"set formatoptions=c,q,r " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)

set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.

set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.

inoremap jk <ESC>
let mapleader = " "

nmap <Leader>q :q<CR>

syntax enable

set backupdir=$HOME/.vim/backup,/tmp
set directory=$HOME/.vim/backup,/tmp
set modeline

" Highlight trailing white-spaces
let c_space_errors=1
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight Comment ctermfg=darkgray
set t_Co=256
let base16colorspace=256  " Access colors present in 256 colorspace
"colorscheme desert256
"colorscheme solarized
try
  colorscheme base16-tomorrow
catch /^Vim\%((\a\+)\)\=:E185/
  " color scheme not installed yet
endtry

" Make Vim restore cursor position in files
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Markdown Preview
map <Leader>md :Mm<CR>

" Tabular
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Drupal
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=drupal.php
    autocmd BufRead,BufNewFile *.module set tabstop=2
    autocmd BufRead,BufNewFile *.module set shiftwidth=2
    autocmd BufRead,BufNewFile *.module set autoindent
    autocmd BufRead,BufNewFile *.module set smartindent

    autocmd BufRead,BufNewFile *.install set filetype=drupal.php
    autocmd BufRead,BufNewFile *.install set tabstop=2
    autocmd BufRead,BufNewFile *.install set shiftwidth=2
    autocmd BufRead,BufNewFile *.install set autoindent
    autocmd BufRead,BufNewFile *.install set smartindent

    autocmd BufRead,BufNewFile *.test set filetype=drupal.php

    autocmd BufRead,BufNewFile *.inc set filetype=drupal.php
    autocmd BufRead,BufNewFile *.inc set tabstop=2
    autocmd BufRead,BufNewFile *.inc set shiftwidth=2
    autocmd BufRead,BufNewFile *.inc set autoindent
    autocmd BufRead,BufNewFile *.inc set smartindent

    autocmd BufRead,BufNewFile *.profile set filetype=drupal.php
    autocmd BufRead,BufNewFile *.view set filetype=drupal.php
    autocmd BufRead,BufNewFile *.tpl.php set filetype=drupal.php
  augroup END
endif

" tab switch
nnoremap <S-h> gT
nnoremap <S-l> gt

" emmet (zencoding)
let g:user_emmet_expandabbr_key='<C-e>'

" use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ack:ag
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" Sort scala imports
autocmd BufWritePre *.scala :silent! undojoin | silent! SortScalaImports
nnoremap <silent> <F5> :EraseBadWhitespace<CR>:SortScalaImports<CR>"

" Fugitive
nmap <Leader>gs :Gstatus<CR><C-w>_<C-n>
nmap <Leader>gci :Gcommit<CR>
nmap <Leader>gd :Gdiff<CR>

" CtrlP
nmap <Leader>t :CtrlP<CR>
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn))|target|data$'

set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

set pastetoggle=<F2>

"" NERDTree
map <C-n> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" multi cursors
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" for triggering webpack watch
set backupcopy=yes

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jscs']

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" YCM
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
