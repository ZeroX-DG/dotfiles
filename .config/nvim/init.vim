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
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'

" Syntax
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'kchmck/vim-coffee-script'
Plug 'ollykel/v-vim'
Plug 'ekalinin/Dockerfile.vim'

" UI
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-emoji'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'liuchengxu/vista.vim'
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kaicataldo/material.vim'
Plug 'archseer/colibri.vim'
Plug 'dylanaraps/wal.vim'

call plug#end()

" -----------------------------[Provider config]---------------------------------
let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3.6"
let g:node_host_prog = "/usr/local/bin/neovim-node-host"

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
set nu rnu
set formatoptions+=j
set foldmethod=syntax   
set foldnestmax=10
set nofoldenable
set foldlevel=2
let s:show_bg=v:true
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

" Floating Term
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let top = "┌" . repeat("─", width + 2) . "┐"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "└" . repeat("─", width + 2) . "┘"
  let lines = [top] + repeat([mid], height) + [bot]
  let bbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(bbuf, 0, -1, v:true, lines)
  let s:float_term_border_win = nvim_open_win(bbuf, v:true, border_opts)
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  hi FloatWinBorder guifg=#87bb7c
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:FloatWinBorder')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  call s:disable_background()
  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)
endfunction

" ----------------------------------[ UI ]-------------------------------------
set background=dark
colorscheme palenight

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

function! s:disable_background()
  highlight Normal ctermbg=none guibg=none
  highlight SignColumn ctermbg=none guibg=none
  highlight LineNr ctermbg=none guibg=none
endfunction

function! s:change_colorscheme(scheme)
  execute 'colorscheme '.a:scheme
  echo 'Colorscheme: '.a:scheme
  let g:lightline.colorscheme = a:scheme
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
  "call s:disable_background()
endfunction

"call s:disable_background()

" -------------------------------[ Prettier ]----------------------------------

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html Prettier

" -------------------------------[ Markdown ]----------------------------------
autocmd! FileType markdown set completefunc=emoji#complete

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set lbr
  call s:disable_background()
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  set nolbr
  call s:disable_background()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" --------------------------------[ Latex ]------------------------------------

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" ------------------------------[ Nerd tree ]----------------------------------
let NERDTreeMinimalUI=1
let NERDTreeShowLineNumbers=1

" -------------------------------[ Keymap ]------------------------------------
" Map leader to space
let mapleader = "\<Space>"

imap jj <Esc>

map qw :wq<CR>
map qq :q<CR>

map <F12> :set nu! rnu!<CR>

" Quick changing colorscheme
map <silent> t1 :call <SID>change_colorscheme('gruvbox')<CR>
map <silent> t2 :call <SID>change_colorscheme('palenight')<CR>
map <silent> t3 :call <SID>change_colorscheme('material')<CR>
map <silent> t4 :call <SID>change_colorscheme('colibri')<CR>
map <silent> t5 :call <SID>change_colorscheme('wal')<CR>

" Split window
nmap sp :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Move between windows
" nnoremap <M-UP> <C-W>k
" nnoremap <M-DOWN> <C-W>j
" nnoremap <M-RIGHT> <C-W>l
" nnoremap <M-LEFT> <C-W>h
nnoremap <M-k> <C-W>k
nnoremap <M-j> <C-W>j
nnoremap <M-l> <C-W>l
nnoremap <M-h> <C-W>h

" Edit helpers
imap <C-d> <ESC>l1xi

" Writing mode
nmap <leader>w :Goyo<CR>

" Code navigation
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> ]c :call CocAction('diagnosticNext')<CR>
nmap <silent> [c :call CocAction('diagnosticPrevious')<CR>

" Move up and down in physical line than logical line
map k gk
map j gj

" Quick edit and apply config
nmap <C-F> :e ~/.config/nvim/init.vim<CR>
nmap <C-K> :source ~/.config/nvim/init.vim<CR>

" Jump to start and end of line
map <C-e> $
map <C-a> 0
imap <C-a> <ESC>I
imap <C-e> <ESC>A

" Close buffer
nnoremap <silent> <M-c> :bw<CR>

" Switch to normal mode in terminal
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" Nerd tree toggle
map <C-N> :NERDTreeToggle<CR>

" Copy to system clipboard
noremap ;y "+y
noremap ;p "+p

" Turn of search highlighting
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Quick save
noremap ss :update<CR>

" Move selection of lines up or down
xnoremap <S-k> :move '<-2<CR>gv-gv
xnoremap <S-j> :move '<+1<CR>gv-gv

" Show docs on K
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Start fuzzy search
noremap <silent> <c-p> <ESC>:call fzf#vim#files('.', {'options': g:fzf_preview_source})<CR>
noremap <silent> <leader>/ <ESC>:BLines<CR>
noremap <leader>rg <ESC>:Rg<CR>
noremap <leader>b :Buffers<CR>

" Git
noremap <leader>gs :Gstatus<CR>
" Thanks thefullsnack
nnoremap <silent> <Leader>ft :call FloatTerm()<CR>
nnoremap <silent> <Leader>fg :call FloatTerm('"tig"')<CR>

" Testing
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

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
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!node_modules"'
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
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ ['fileicon'], [ 'cocstatus' ], [ 'filename', 'nearmethod' ] ],
      \   'right': [ [ 'icongitbranch' ], [ 'lineinfo' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [], ['fileicon'], [ 'filename' ] ],
      \   'right': []
      \ },
      \ 'component': { 'lineinfo': ' %2p%% [%v|%l/%L]' },
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
