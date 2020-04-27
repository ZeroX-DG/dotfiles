" ------------------------------[ Packages ]-----------------------------------
call plug#begin('~/.local/share/nvim/plugged')

" Tools
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'

" Syntax
Plug 'posva/vim-vue'
Plug 'lervag/vimtex'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'kchmck/vim-coffee-script'
Plug 'ollykel/v-vim'

" UI
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-emoji'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'liuchengxu/vista.vim'
Plug 'morhetz/gruvbox'
call plug#end()

" -----------------------------[Python config]---------------------------------
let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3.6"

" ----------------------------[ General config ]-------------------------------
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
set formatoptions+=j

" Define characters to show when you show formatting
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
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

" ----------------------------------[ UI ]-------------------------------------
set background=dark
colorscheme gruvbox
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" -------------------------------[ Prettier ]----------------------------------

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" -------------------------------[ Markdown ]----------------------------------
autocmd! FileType markdown set completefunc=emoji#complete

" --------------------------------[ Latex ]------------------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=1
set conceallevel=1
let g:tex_conceal='abdmg'

" ------------------------------[ Nerd tree ]----------------------------------
map <C-N> :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1

" -------------------------------[ Keymap ]------------------------------------

" Quick escape to normal
map jj <Esc>

" Split window
nmap sp :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Move between windows
nnoremap <M-UP> <C-W>k
nnoremap <M-DOWN> <C-W>j
nnoremap <M-RIGHT> <C-W>l
nnoremap <M-LEFT> <C-W>h

" Jump to Goyo when space
map <silent><SPACE> :Goyo<CR>

" Move up and down in physical line than logical line
map <UP> gk
map <DOWN> gj

" Quick edit config
nmap <C-F> :e ~/.config/nvim/init.vim<CR>

" Jump to start and end of line
map <C-e> $
map <C-a> 0
imap <C-a> <ESC>I
imap <C-e> <ESC>A

" Close buffer
nnoremap <silent> <M-c> :bw<CR>

" Copy to system clipboard
noremap ;y "+y
noremap ;p "+p

" Turn of search highlighting
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Quick save
noremap ss :update<CR>

" Move selection of lines up or down
xnoremap <S-UP> :move '<-2<CR>gv-gv
xnoremap <S-DOWN> :move '<+1<CR>gv-gv

" Map :W to :w because I always type :W
cmap W w

" Show docs on K
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Start fuzzy search
noremap <silent> <c-p> <ESC>:call fzf#vim#files('.', {'options': g:fzf_preview_source})<CR>
noremap <silent> <leader>/ <ESC>:BLines<CR>
noremap <leader>rg <ESC>:Rg<space>

" ---------------------------[ Language Server ]-------------------------------
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

call SetupCommandAbbrs('C', 'CocConfig')
command! -nargs=0 Format :call CocAction('format')
autocmd CursorHold * silent call CocActionAsync('highlight')

" ----------------------------[ Fuzzy search ]---------------------------------
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_preview_source=" --preview='bat {} --theme='TwoDark' --color=always'"
let $FZF_DEFAULT_OPTS='--layout=reverse'

" -----------------------------[ Status Line ]---------------------------------
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

" ------------------------------[ Syntax ]-------------------------------------
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
