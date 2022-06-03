let g:isnvim = 0

if has('nvim')
  let g:isnvim = 1
endif

if g:isnvim == 0
  " Vim with all enhancements
  source $VIMRUNTIME/vimrc_example.vim
endif


" ===
" === Auto load plug.vim for first time uses.
" ===
if g:isnvim
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    au VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    au VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

let g:iswindows = 0
let g:islinux = 0

if(has("win32") || has("win64") || has("win95") || has("win16"))
  let g:iswindows = 1
  let g:main_config_file = '_vimrc'
else
  let g:islinux = 1
  let g:main_config_file = '.vimrc'
endif

if g:isnvim
  let g:main_config_file = 'init.vim'
endif

if has("gui_running")
  let g:isGUI = 1
else
  let g:isGUI = 0
endif

""" Hide manu bar, tool bar...
if g:isGUI
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
        \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
        \endif<cr>
endif

""" vim-plug
if g:isnvim
  call plug#begin(stdpath('data').'/plugged')
else
  call plug#begin("~/.vim/plugged")
endif
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'rakr/vim-one'
Plug 'mhinz/vim-startify'
Plug 'vimwiki/vimwiki'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'ryanoasis/vim-devicons'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'nikvdp/neomux'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do' : ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
""" <PlugEnd>
call plug#end()

""" Basic settings.
set noundofile
set shiftwidth=2
set autoindent
set cindent
set hlsearch
set incsearch
set nocompatible
set expandtab
set smarttab
set wrap
" When a file was edited by external editors, auto update file content.
set autoread
set number
set scrolloff=8

if &modifiable
  set encoding=utf-8
  set fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1

  set fileformat=unix
  set fileformats=unix,dos,mac
endif

set ignorecase
" when use Capital letters, ignore the ignorecase option
set smartcase

" highlight current line
set cursorline
set writebackup
set nobackup
"set cc=80
"
colorscheme solarized8

" Delete trailing spaces.
nnoremap cS :%s/\s\+$//g<cr>:noh<cr>
" Delete trailing ^M mark.
nnoremap cM :%s/\r$//g<cr>:noh<cr>
" No hlsearch
map <silent><leader>\ :noh<cr>
" Spelling check.
map <leader>sc :set spell!<cr>
" Press space twice to jump to the next '<++>' and edit it.
map <space><space> <esc>/<++><cr>:noh<cr>c4i

imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

"<F7> open vim configuration file
function! ToggleVimrcWindow()
  let vimrcwinnr = bufwinnr(g:main_config_file)
  if(vimrcwinnr != -1 && winnr("$") != 1)
    exe "close ".vimrcwinnr
  else
    exe "norm! :sp" $MYVIMRC "\<cr>"
  endif
endfunction

nmap <F7> :call ToggleVimrcWindow()<cr>

nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

if g:isGUI
  winpos 100 10
  set lines=38 columns=120
endif

" 自动切换目录为当前编辑文件所在目录
au BufRead,BufNewFile,BufEnter * cd %:p:h

if (g:iswindows && g:isGUI)
  " 解决菜单乱码
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
  " 解决console输出乱码
  language message zh_CN.utf-8
endif

" ====
" ====  a.vim
" ====
nnoremap <F4> :A<cr>


" ====
" ====  vimwiki
" ====
let g:vimwiki_list = [{'path': '~/vimwiki/',
      \ 'syntax': 'markdown', 'ext': '.md'}]

" ====
" ==== Tagbar
" ====
nmap tb :TagbarToggle<cr>
let g:tagbar_width=30
let g:tagbar_sort=0
autocmd FileType tagbar setlocal nocursorline nocursorcolumn
" let g:tagbar_left=1

""" tags
set tags+=tags;

""" vim-autoformat
let g:formatdef_clangformat = '"clang-format"'
" c, cpp
let g:formatters_cpp = ['clangformat']
let g:formatters_c = ['clangformat']
" python
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8']
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

inoremap <silent> <F6> <esc>:Autoformat<cr>
noremap <silent> <F6> <esc>:Autoformat<cr>

""" nerdtree
nmap <F2> :NERDTreeToggle<cr>

""" airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
if g:isGUI
  set guifont=JetBrainsMono_NF:h11
  set rop=type:directx,gamma:2,contrast:1,level:10,geom:1,renmode:5,taamode:1
  set linespace=6
endif

""" UltiSnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-f>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/snippets']

""" vim-easy-align
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

""" coc.nvim
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" fzf
" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" Empty value to disable preview window altogether
let g:fzf_preview_window = []

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

lua require('plugins')
lua require('init')


" telescope stuff
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
