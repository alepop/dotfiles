""" Coloring
syntax on
set t_Co=256
colorscheme one
let g:one_allow_italics = 1
set background=light
let &t_ut=''
" Opaque Background (Comment out to use terminal's profile)
set termguicolors

""" Other Configurations
filetype plugin indent on
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\
set wrap breakindent
set encoding=utf-8
set number
set title


""" COC recomendet settings
" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes


""" Key bindings
let g:mapleader = "\<Space>"
let g:maplocalleader = ','


""" Minpac
if exists('*minpac#init')
  call minpac#init()

  " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Add other plugins here.
  " one color theme
  call minpac#add('rakr/vim-one')
  call minpac#add('NLKNguyen/papercolor-theme')

  " status line
  call minpac#add('itchyny/lightline.vim')
  " which-key
  call minpac#add('liuchengxu/vim-which-key')
  " devicon
  call minpac#add('ryanoasis/vim-devicons')


  " fzf
  call minpac#add('junegunn/fzf', {'do': './install --bin'})
  call minpac#add('junegunn/fzf.vim')

  " coc
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

  " polyglot
  call minpac#add('sheerun/vim-polyglot')

  " Enable git changes to be shown in sign column
  call minpac#add('mhinz/vim-signify')
  call minpac#add('tpope/vim-fugitive')

  " Ale
  call minpac#add('dense-analysis/ale')

  " Commentary
  call minpac#add('tpope/vim-commentary')

endif

" load packages
packloadall

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()


""" Plugin config

" Lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'git', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Which Key
set timeoutlen=500
let g:which_key_use_floating_win = 1
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
call which_key#register('<Space>', "g:which_key_map")
"
" Define prefix dictionary
let g:which_key_map =  {}

" COC
let g:coc_global_extensions = [
      \"coc-css",
      \"coc-emmet",
      \"coc-emoji",
      \"coc-eslint",
      \"coc-explorer",
      \"coc-git",
      \"coc-gitignore",
      \"coc-highlight",
      \"coc-html",
      \"coc-imselect",
      \"coc-json",
      \"coc-lists",
      \"coc-marketplace",
      \"coc-pairs",
      \"coc-prettier",
      \"coc-project",
      \"coc-snippets",
      \"coc-svelte",
      \"coc-tailwindcss",
      \"coc-tslint-plugin",
      \"coc-tsserver",
      \"coc-vimlsp",
      \"coc-yaml",
      \"coc-yank"
      \]

if executable('java')
  let g:coc_global_extensions += ['coc-java']
endif
if executable('python')
  let g:coc_global_extensions += ['coc-python']
endif
if executable('go')
  let g:coc_global_extensions += ['coc-gocode']
endif
if executable('rust')
  let g:coc_global_extensions += ['coc-rls']
endif
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

" autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Ale
" fix files on save
let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 500


" fixer configurations
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'javascript': ['eslint'],
      \ }


""" Keys mappings
" Global
inoremap jk <ESC>

" File
let g:which_key_map.f = {
      \ 'name': '+file',
      \ 'f': ['coc#rpc#notify("openList",["--tab", "-A", "files"])', 'searh-files'],
      \ 'g': {
      \ 'name': '+git',
      \   's': ['coc#rpc#notify("openList", ["--normal", "--tab", "-A", "gstatus"])', 'git-status'],
      \ },
      \ }

nnoremap <silent><leader>fd :e $MYVIMRC<CR>
let g:which_key_map.f.d = 'open-vimrc'

" Window
let g:which_key_map.w = {
      \ 'name' : '+windows' ,
      \ 'c' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 'w': ['coc#rpc#notify("openList",["--normal", "windows"])', 'windows'],
      \ }

" Buffers
let g:which_key_map.b = {
      \ 'name': '+buffer',
      \ 'n': ['bnext', 'next-buffer'],
      \ 'p': ['bprevious', 'previous-buffer'],
      \ 'c': ['bunload', 'unload-buffer'],
      \ 'b': ['coc#rpc#notify("openList",["--normal", "buffers"])', 'buffers'],
      \ }

" Go To
let g:which_key_map.g = {
      \ 'name': '+goto',
      \ 'd': ['CocAction("jumpDefinition")', 'go-to-definition'],
      \ 'i': ['CocAction("jumpImplementation")', 'go-to-implementation'],
      \ 'y': ['CocAction("jumpTypeDefinition")', 'go-to-type-defenition'],
      \ 'r': ['CocAction("jumpReferences")', 'go-to-reference'],
      \ 'w': ['Rg', 'find-word'],
      \ 'l': ['CocAction("openLink")', 'open-link'],
      \ }

" CocList
let g:which_key_map.l = { 'name': '+list' }

nnoremap <silent> <space>lo  :<C-u>CocList -A --tab --normal outline<cr>
let g:which_key_map.l.o = 'outline'
"
" Show all diagnostics
nnoremap <silent> <space>ld  :<C-u>CocList --normal -A diagnostics<cr>
let g:which_key_map.l.d = 'diagnostics'

" Search workspace symbols
nnoremap <silent> <space>ls  :exe 'CocList -I --tab -A --input='.expand('<cword>').' symbols'<CR>
let g:which_key_map.l.s = 'symbols'

" Coc Explorer
let g:which_key_map.e = { 'name' : '+explore' }

nnoremap <silent> <space>ey  :<C-u>CocList -A --normal yank<cr>
let g:which_key_map.e.y = 'explore-yanks'

" :nmap <space>e :CocCommand explorer<CR>
let g:coc_explorer_global_presets = {
      \   '.vim': {
      \      'root-uri': '~/.vim',
      \   },
      \   'floating': {
      \      'position': 'floating',
      \   },
      \   'floatingLeftside': {
      \      'position': 'floating',
      \      'floating-position': 'left-center',
      \      'floating-width': 50,
      \   },
      \   'floatingRightside': {
      \      'position': 'floating',
      \      'floating-position': 'left-center',
      \      'floating-width': 50,
      \   },
      \   'simplify': {
      \     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
      \   }
      \ }
nmap <space>ef :CocCommand explorer --preset floating<CR>

let g:which_key_map.e.f = 'explore-files'

" Pretier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format-selected)
