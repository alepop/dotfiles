" Plugins {{{
if exists('*minpac#init')
    call minpac#init()

    " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Add other plugins here.
    " status line
    call minpac#add('itchyny/lightline.vim')

    " which-key
    call minpac#add('liuchengxu/vim-which-key')

    " editorconfig
    call minpac#add('editorconfig/editorconfig-vim')

    " fzf
    call minpac#add('junegunn/fzf', {'do': './install --bin'})
    call minpac#add('junegunn/fzf.vim')

    " COC
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
    " COC plugins {{{
    let g:coc_global_extensions = [
                \"coc-css",
                \"coc-emmet",
                \"coc-emoji",
                \"coc-explorer",
                \"coc-git",
                \"coc-gitignore",
                \"coc-highlight",
                \"coc-html",
                \"coc-json",
                \"coc-lists",
                \"coc-marketplace",
                \"coc-pairs",
                \"coc-prettier",
                \"coc-project",
                \"coc-snippets",
                \"coc-svelte",
                \"coc-tailwindcss",
                \"coc-tsserver",
                \"coc-vimlsp",
                \"coc-yaml",
                \"coc-yank"
                \]

    if executable('python')
        let g:coc_global_extensions += ['coc-python']
    endif
    if executable('go')
        let g:coc_global_extensions += ['coc-gocode']
    endif
    if executable('rust')
        let g:coc_global_extensions += ['coc-rls']
    endif
    " }}}

    " AnyJump
    call minpac#add('pechorin/any-jump.vim')

    " polyglot
    call minpac#add('sheerun/vim-polyglot')

    " Ale
    call minpac#add('dense-analysis/ale')
    call minpac#add('desmap/ale-sensible')

    " Commentary
    call minpac#add('tpope/vim-commentary')

    " Surrond
    call minpac#add('tpope/vim-surround')

    " Git
    call minpac#add('tpope/vim-fugitive')

    " color
    call minpac#add('rakr/vim-one')
    call minpac#add('cormacrelf/vim-colors-github')

    " Dash
    call minpac#add('rizzatti/dash.vim')
endif

" load packages
" Matchit {{{
if !has('nvim')
    " Start matchit
    packadd! matchit
endif
" Use Tab instead of % to switch
nmap <Tab> %
vmap <Tab> %
" }}}
packloadall
" Minpac config {{{
" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
" }}}
" }}}
" Base {{{
" Settings {{{
set number relativenumber " Use "hybrid" (both absolute and relative) line numbers
set hidden " Possibility to have more than one unsaved buffers.
set ignorecase " Search insensitive
set smartcase
set incsearch " Incremental search.
set hlsearch " Highlight search results
set clipboard=unnamed " Use the system clipboard
set colorcolumn=80 " Use a color column on the 80-character mark
set expandtab shiftwidth=2 " Press <tab>, get two spaces
set list listchars=tab:▸▸,trail:· " Show `▸▸` for tabs: 	, `·` for tailing whitespace:
" }}}
" Fold settings {{{
set foldmethod=syntax                              " how to determine folds
set foldlevelstart=1 " Start with all folds closed
" set foldcolumn=1 " Set fold column
set nofoldenable
au BufRead *.vim,.*vimrc setlocal foldenable foldmethod=marker foldlevel=0
" }}}
" Key bindings {{{
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
inoremap jk <ESC>
" }}}
" }}}
" Lightline {{{
let g:lightline = {
            \ 'colorscheme': 'github',
            \ 'active': {
            \   'left': [
            \     [ 'mode', 'paste' ],
            \     [ 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
            \   ],
            \   'right':[
            \     [ 'filetype', 'fileencoding', 'lineinfo'],
            \   ],
            \ },
            \ 'component_function': {
            \   'blame': 'LightlineGitBlame',
            \   'cocstatus': 'coc#status'
            \ }
            \ }
" Functions {{{
function! LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    " return blame
    return winwidth(0) > 120 ? blame : ''
endfunction
"
" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
" }}}
" }}}
" Colors {{{
set termguicolors
set cursorline
colorscheme github

function! FixThemeColors()
    " fix colors for gitgutter"
    highlight! SignColumn guibg=#fafbfc ctermbg=255
endfunction

augroup mycolorscheme
    autocmd!
    autocmd ColorScheme * call FixThemeColors()
augroup end
" }}}
" Which Key {{{
" Plugin settings {{{
set timeoutlen=300
let g:which_key_use_floating_win = 1
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
call which_key#register('<Space>', "g:which_key_map")
call which_key#register(',', "g:which_local_key_map")

let g:which_key_map =  {} " Define prefix dictionary
let g:which_local_key_map = {}
" }}}
" 'F' key (Files) {{{
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
" }}}
" 'W' key (Windows) {{{
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

" }}}
" 'B' key (Buffers) {{{
let g:which_key_map.b = {
            \ 'name': '+buffer',
            \ 'n': ['bnext', 'next-buffer'],
            \ 'p': ['bprevious', 'previous-buffer'],
            \ 'c': ['bunload', 'unload-buffer'],
            \ 'b': ['coc#rpc#notify("openList",["--normal", "buffers"])', 'buffers'],
            \ }

" }}}
" 'G' key (Go-to) {{{
let g:which_key_map.g = {
            \ 'name': '+goto',
            \ 'd': ['CocAction("jumpDefinition")', 'go-to-definition'],
            \ 'i': ['CocAction("jumpImplementation")', 'go-to-implementation'],
            \ 'y': ['CocAction("jumpTypeDefinition")', 'go-to-type-defenition'],
            \ 'r': ['CocAction("jumpReferences")', 'go-to-reference'],
            \ 'w': ['Rg', 'find-word'],
            \ 'l': ['CocAction("openLink")', 'open-link'],
            \ }
" }}}
" 'L' key (CocList's) {{{
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
" }}}
" 'E' key (Explorer) {{{
let g:which_key_map.e = { 'name' : '+explore' }

nnoremap <silent> <space>ey  :<C-u>CocList -A --normal yank<cr>
let g:which_key_map.e.y = 'explore-yanks'

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
" }}}
" }}}
" COC config {{{
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

autocmd CursorHold * silent call CocActionAsync('highlight')

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

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" }}}
" Ale {{{
" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 300
let g:ale_fix_on_save = 1
" Linters {{{
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'javascript': ['eslint'],
            \   'typescript': ['tslint'],
            \ }
" }}}
" }}}
" Pretier {{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format-selected)
let g:which_local_key_map.f = 'format-selected'
" }}}
" Git {{{
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" }}}
" Dash {{{
:nmap <silent><localleader>d <Plug>DashSearch
let g:which_local_key_map.d = 'search-in-dash-docsets'
" }}}
