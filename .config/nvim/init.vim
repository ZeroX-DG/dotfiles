" ZeroX VIM
" Version: 1.0.0

" Package installer
" ----------------------------------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'posva/vim-vue'
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-emoji'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'wellle/targets.vim'
Plug 'junegunn/gv.vim'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'liuchengxu/vista.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'lervag/vimtex'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'kchmck/vim-coffee-script'
Plug 'ajmwagar/vim-deus'
Plug 'ollykel/v-vim'
Plug 'morhetz/gruvbox'
call plug#end()

" Python config
" ----------------------------------
let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3.6"

" Editor config
" ----------------------------------
filetype plugin indent on
syntax enable
set encoding=UTF-8
set hidden
set nocompatible
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set incsearch
set laststatus=2
set ruler
set showcmd
set wildmenu
set display+=lastline
set encoding=utf-8
set autoread
set fileformats+=mac
set autochdir
set colorcolumn=80
set cmdheight=2
set expandtab
set bs=2 tabstop=2 shiftwidth=2 softtabstop=2
set termguicolors
set nobackup
set nowritebackup
set splitbelow
set splitright
set nu

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif
if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" UI
" ----------------------------------
set background=dark
" colorscheme palenight
" colorscheme deus
colorscheme gruvbox
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Git related 
" ----------------------------------
let g:gitgutter_sign_added = emoji#for('heavy_plus_sign')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('heavy_minus_sign')
let g:gitgutter_sign_modified_removed = emoji#for('collision')
map <C-G> :GitGutterToggle<CR>
set diffopt+=vertical

" Prettier
" ----------------------------------

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" Markdown
" ----------------------------------
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
autocmd! FileType markdown set completefunc=emoji#complete

" Latex
" ----------------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=1
set conceallevel=1
let g:tex_conceal='abdmg'

" Web dev
" ----------------------------------
let g:user_emmet_install_global = 0
autocmd FileType php,html EmmetInstall

" Nerd tree
" ----------------------------------
map <C-N> :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1

" Keymap
" ----------------------------------

" Quick escape to normal
imap jj <Esc>

" Split window
nmap sp :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

nnoremap <M-j> <C-W>j
nnoremap <M-k> <C-W>k
nnoremap <M-l> <C-W>l
nnoremap <M-h> <C-W>h

nnoremap <M-UP> <C-W>k
nnoremap <M-DOWN> <C-W>j
nnoremap <M-RIGHT> <C-W>l
nnoremap <M-LEFT> <C-W>h

map <UP> gk
map <DOWN> gj

nnoremap <silent> <tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

nmap <C-F> :e ~/.config/nvim/init.vim<CR>
map <C-e> <ESC>$
imap <C-a> <ESC>I
imap <C-G> <Esc>$i
nnoremap <silent> <M-c> :bw<CR>
noremap ;y "+y
noremap ;p "+p
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
noremap <silent> <F12> :set rnu!<CR>
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>
noremap ss :update<CR>

" Tagbar
" ----------------------------------
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_rust = {
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \'T:types,type definitions',
      \'f:functions,function definitions',
      \'g:enum,enumeration names',
      \'s:structure names',
      \'m:modules,module names',
      \'c:consts,static constants',
      \'t:traits',
      \'i:impls,trait implementations',
  \]
  \}

" Coc
" ----------------------------------
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
call SetupCommandAbbrs('C', 'CocConfig')
command! -nargs=0 Format :call CocAction('format')
autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <leader>rn <Plug>(coc-rename)
" FZF
" ----------------------------------
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_preview_source=" --preview='bat {} --theme='TwoDark' --color=always'"
noremap <silent> <c-p> <ESC>:call fzf#vim#files('.', {'options': g:fzf_preview_source})<CR>
noremap <silent> <leader>/ <ESC>:BLines<CR>
noremap <leader>rg <ESC>:Rg<space>
noremap <c-]> <ESC>:call fzf#vim#tags(expand("<cword>"), {'options': '--exact'})<cr>
let $FZF_DEFAULT_OPTS='--layout=reverse'

" Vim Multiple Cursors
" ----------------------------------
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-m>'
let g:multi_cursor_select_all_word_key = '<A-m>'
let g:multi_cursor_start_key           = 'g<C-m>'
let g:multi_cursor_select_all_key      = 'g<A-m>'
let g:multi_cursor_next_key            = '<C-m>'
let g:multi_cursor_prev_key            = '<C-j>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Light line
" ----------------------------------
function! NearestMethodOrFunction() abort
  let fname = get(b:, 'vista_nearest_method_or_function', '')
  return len(fname) > 0 ? "\u0192 " . fname : ""
endfunction

function! DrawGitBranchInfo()
  let branch = fugitive#head()
  return len(branch) > 0 ? " " . branch : ""
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : '') : ''
endfunction

function! LightLineFilename()
  let name = ""
  let subs = split(expand('%'), "/")
  let i = 1
  for s in subs
    let parent = name
    if  i == len(subs)
      let name = len(parent) > 0 ? parent . '/' . s : s
    elseif i == 1
      let name = s
    else
      let part = strpart(s, 0, 10)
      let name = len(parent) > 0 ? parent . '/' . part : part
    endif
    let i += 1
  endfor
  return name
endfunction

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ ['fileicon'], [ 'cocstatus' ], [ 'filename', 'nearmethod' ] ],
      \   'right': [ [ 'icongitbranch' ], [ 'lineinfo' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [], ['fileicon'], [ 'filename' ] ],
      \   'right': []
      \ },
      \ 'component': { 'lineinfo': ' %2p%% %3l:%-2v' },
      \ 'component_function': {
      \   'fileicon': 'MyFiletype',
      \   'icongitbranch': 'DrawGitBranchInfo',
      \   'iconline': 'DrawLineInfo',
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'filename': 'LightLineFilename',
      \   'nearmethod': 'NearestMethodOrFunction'
      \ },
      \ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
