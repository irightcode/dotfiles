set nocompatible
filetype off

set rtp+=$HOME/.vim/bundle/Vundle.vim/
set rtp+=/usr/local/opt/fzf
call vundle#begin('$HOME/.vim/bundle/')

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" My Bundles
Plugin 'vim-airline/vim-airline'
Plugin 'junegunn/fzf.vim'
" Completion
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'nanotech/jellybeans.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'rking/ag.vim'
Plugin 'w0rp/ale'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'justinmk/vim-dirvish'
Plugin 'kristijanhusak/vim-dirvish-git'

"" Notes
Plugin 'dhruvasagar/vim-dotoo'
"" Indent
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'vim-scripts/argtextobj.vim'
"" File Type
Plugin 'tpope/vim-rails'
Plugin 'scrooloose/nerdtree'
Plugin 'leafgarland/typescript-vim'
Plugin 'fatih/vim-go'
Plugin 'hashivim/vim-terraform.git'
Plugin 'PProvost/vim-ps1'

call vundle#end()

filetype plugin indent on

color jellybeans

set hidden
set cursorline
set expandtab
set modelines=0
set shiftwidth=2
set clipboard=unnamed
set synmaxcol=128
set ttyscroll=10
set guioptions-=m
set guioptions-=T
set mouse=a
set ttymouse=xterm2
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

set guifont=Consolas:h10:cANSI:qDRAFT

if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

autocmd BufNewFile * set noeol

" No show command
autocmd VimEnter * set nosc

" Mappings
let mapleader=","
nnoremap \ ,

" Jump to the next row on long lines
map <Down> gj
map <Up>   gk
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

" Underline (maybe should be filetype bound)
nmap <silent> <leader>u= :t.\|s/./=/g\|:nohls<cr>
nmap <silent> <leader>u- :t.\|s/./-/g\|:nohls<cr>
nmap <silent> <leader>u~ :t.\|s/./\\~/g\|:nohls<cr>

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" Goto File
nnoremap <leader>gv :vsplit $MYVIMRC<cr>

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

" CtrlP
nnoremap <leader>p :CtrlP<cr>
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.sass-cache$|\.hg$\|\.svn$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.a$\|\.so$\|\.dat$|\.DS_Store$'
  \ }
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
" autocmd FileType go nmap <leader>b <Plug>(go-build)
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

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
