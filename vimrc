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

map <Left>  <nop>
map <Right> <nop>
map <Down>  <nop>
map <Up>    <nop>

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
nmap <leader>p "*p
vmap <leader>p "*p

" Ag.vim to use ripgrep
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
end

" Airline
let g:airline_powerline_fonts = 1

" Git Gutter
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

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

" Golang Mappings
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go set autowrite
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"Terraform
let g:terraform_align=1
autocmd FileType terraform setlocal commentstring=#%s

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

function! s:delete_trailing_whitespace()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

noremap <leader>w :<C-u>call <SID>delete_trailing_whitespace()<CR>

" Vim wiki
" let g:vimwiki_list = [{'path': '~/dev/vimwiki/',
"                       \ 'syntax': 'markdown', 'ext': '.md'}]

