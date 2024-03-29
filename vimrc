set nocompatible
filetype off

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

color gruvbox

set hidden
set cursorline
set expandtab
set modelines=0
set shiftwidth=2
" set ttyscroll=10
" set ttymouse=xterm2
set guioptions-=m
set guioptions-=T
set mouse=a
set encoding=utf-8
set completeopt-=preview
set tabstop=2
set nowrap
set number
set expandtab
set nowritebackup
set noswapfile
set nobackup
set hlsearch
set ignorecase
set smartcase
set undofile
set undodir=~/.vim/undo
set t_Co=256
set guifont=Consolas:h10:cANSI:qDRAFT
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

if has("termguicolors")
  set termguicolors
endif

autocmd BufNewFile * set noeol

" No show command
autocmd VimEnter * set nosc

" Mappings
let mapleader=" "

map  <Left>  <nop>
map  <Right> <nop>
map  <Down>  <nop>
map  <Up>    <nop>
imap <Left>  <nop>
imap <Right> <nop>
imap <Down>  <nop>
imap <Up>    <nop>

" Jump to the next row on long lines
nnoremap j gj
nnoremap k gk

" format the entire file
nmap <leader>fef ggVG=

" cd to the current file's directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
cnoremap %% %:p:h

" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>

nmap <silent> <Leader>jk :nohlsearch<CR>
" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" Goto File
nnoremap <leader>gv :vsplit $MYVIMRC<cr>

nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>Y "*Y
vmap <leader>Y "*Y
nmap <leader>p "*p
vmap <leader>p "*p
nmap <leader>P "*P
vmap <leader>P "*P

" Ag.vim to use ripgrep
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
end

nnoremap <Leader>/ :Ack<Space>


" Airline
let g:airline_powerline_fonts = 1

" Git Gutter
let g:gitgutter_map_keys = 0
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

" Fuzzy Find stuff
nnoremap <leader>ff :GFiles<cr>
nnoremap <leader>fF :Files<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <Leader>fl :BLines<CR>
nnoremap <Leader>fL :Lines<CR>
nnoremap <Leader>ft :BTags<CR>
nnoremap <Leader>fT :Tags<CR>
nnoremap <Leader>fh :History<CR>
nnoremap <Leader>f: :History:<CR>
nnoremap <Leader>fM :Maps<CR>
nnoremap <Leader>fC :Commands<CR>
nnoremap <Leader>f' :Marks<CR>
nnoremap <Leader>fs :Filetypes<CR>
nnoremap <Leader>fS :Snippets<CR>
"
" Vim Dispatch
nmap <leader>d :Dispatch<cr>

" Quit with :Q
command! -nargs=0 Quit :qa!

nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

" Vimwiki and Vinegar conflicts
nmap <Nop> <Plug>VimwikiRemoveHeaderLevel

