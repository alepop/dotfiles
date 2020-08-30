" Plugins {{{
if exists('*minpac#init')
    call minpac#init()
    " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    " status line
    call minpac#add('itchyny/lightline.vim')
    " which-key
    call minpac#add('liuchengxu/vim-which-key')
    " editorconfig
    call minpac#add('editorconfig/editorconfig-vim')
    " fzf
    call minpac#add('junegunn/fzf', {'do': '!./install --bin'})
    call minpac#add('junegunn/fzf.vim')
    " COC
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
    " COC plugins {{{
    let g:coc_global_extensions = [
                \"coc-css",
                \"coc-html",
                \"coc-explorer",
                \"coc-git",
                \"coc-gitignore",
                \"coc-highlight",
                \"coc-json",
                \"coc-lists",
                \"coc-marketplace",
                \"coc-pairs",
                \"coc-prettier",
                \"coc-project",
                \"coc-snippets",
                \"coc-tsserver",
                \"coc-vimlsp",
                \"coc-actions",
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
    call minpac#add('evanleck/vim-svelte')
    " Commentary
    call minpac#add('tpope/vim-commentary')
    " Surrond
    call minpac#add('tpope/vim-surround')
    " Git
    call minpac#add('tpope/vim-fugitive')
    " ColorSchemes
    call minpac#add('morhetz/gruvbox')
    call minpac#add('dracula/vim', { 'name': 'dracula'})
    " Markdown preview
    call minpac#add('iamcco/markdown-preview.nvim', {'do': '!yarn install', 'type': 'opt'})
    " C# and Unity
    call minpac#add('OmniSharp/omnisharp-vim')
endif

" Minpac config {{{
" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
" }}}
" }}}
" Base Settings {{{
syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler               	            " Show the cursor position all the time
set cmdheight=1                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set number relativenumber               " Line numbers
set cursorline                          " Enable highlighting of the current line
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=100                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set ignorecase                          " Search insensitive
set inccommand=split                    " live preview of command (search and replace)
set smartcase
set noswapfile
set undodir=~/.vim/undodir
set undofile
set shortmess+=c
set termguicolors

set background=dark
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_invert_selection='0'
packadd! dracula
colorscheme dracula

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
" Autocmd {{{
autocmd ColorScheme * hi! link SignColumn LineNr
autocmd ColorScheme * hi! GruvboxAquaSign guibg=NONE
autocmd ColorScheme * hi! GruvboxGreenSign guibg=NONE
autocmd ColorScheme * hi! GruvboxRedSign guibg=NONE
" autocmd ColorScheme * hi! Normal ctermbg=NONE guibg=NONE
" autocmd ColorScheme * hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.html :Format
autocmd BufWritePre *.cs OmniSharpCodeFormat

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
" }}}
" Fold {{{
set foldmethod=syntax                              " how to determine folds
set foldlevelstart=1 " Start with all folds closed
set nofoldenable
au BufRead *.vim,.*vimrc setlocal foldenable foldmethod=marker foldlevel=0
" }}}
" Key mapings {{{
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
inoremap jk <ESC>

" Disable highlight with esc
nmap <silent> <leader>/ :nohlsearch<CR>

" Move lines up and down in visual mode
vnoremap <silent> <C-j> :m '>+1<CR>gv=gv
vnoremap <silent> <C-k> :m '<-2<CR>gv=gv

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use alt + hjkl to resize windows
nnoremap <A-j>    :resize -2<CR>
nnoremap <A-k>    :resize +2<CR>
nnoremap <A-h>    :vertical resize -2<CR>
nnoremap <A-l>    :vertical resize +2<CR>

" TAB in general mode will move to text buffer
" nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
" nnoremap <S-TAB> :bprevious<CR>

" exit terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
" }}}
" }}}
" Lightline {{{
let g:lightline = {
            \ 'colorscheme': 'dracula',
            \ 'active': {
            \   'left': [
            \     [ 'mode', 'paste' ],
            \     [ 'gitbranch', 'diagnostic', 'cocstatus', 'filename', 'modified' ]
            \   ],
            \   'right':[
            \     [ 'filetype', 'fileencoding', 'percent', 'lineinfo'],
            \   ],
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status',
            \   'gitbranch': 'FugitiveHead'
            \ }
            \ }
" Functions {{{
"
" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
" }}}
" }}}
" Which Key {{{
" Plugin settings {{{
packadd vim-which-key
set timeoutlen=200
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
            \ 'f': [':CocList files', 'searh-files'],
            \ 'g': {
            \ 'name': '+git',
            \   's': [':CocList --normal --tab -A gstatus', 'git-status'],
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
            \ '=' : ['<C-W>='     , 'balance-window']        ,
            \ 'w' : [':CocList --normal windows', 'windows'],
            \ }

" }}}

" 'B' key (Buffers) {{{
let g:which_key_map.b = {
            \ 'name': '+buffer',
            \ 'n': ['bnext', 'next-buffer'],
            \ 'p': ['bprevious', 'previous-buffer'],
            \ 'c': ['bunload', 'unload-buffer'],
            \ 'b': ['coc#rpc#notify("openList",["buffers"])', 'buffers'],
            \ }

" }}}

" 'G' key (Go-to) {{{
let g:which_key_map.g = {
            \ 'name': '+goto',
            \ 'i': ['CocAction("jumpImplementation")', 'go-to-implementation'],
            \ 'y': ['CocAction("jumpTypeDefinition")', 'go-to-type-defenition'],
            \ 'r': ['CocAction("jumpReferences")', 'go-to-reference'],
            \ 'w': [':Rg', 'find-word'],
            \ 'd': ['<Plug>(coc-definition)', 'go-to-defenition'],
            \ }
nmap <silent><leader>gD :vsp<CR><Plug>(coc-definition)
let g:which_key_map.g.D = 'go-to-defenition in vslpit'

nnoremap <leader>gW :CocSearch <C-R>=expand("<cword>")<CR><CR>
let g:which_key_map.g.W = 'search current word'
" }}}

" 'L' key (CocList's) {{{
let g:which_key_map.l = { 'name': '+list' }

nnoremap <silent> <space>lo  :<C-u>CocList -A --tab outline<cr>
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

nmap <silent><space>ef :CocCommand explorer --quit-on-open --sources buffer-,file+<CR>

let g:which_key_map.e.f = 'explore-files'
" }}}
"  'D' key (Diagnostic) {{{
let g:which_key_map.d = [':CocList diagnostics', 'diagnostics']
"  }}}
"  'T' key {{{
let g:which_key_map.t = [':CocCommand terminal.Toggle', 'terminal']
"  }}}
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
    if (index(['cs'], &filetype) >= 0)
      call OmniSharp#actions#documentation#TypeLookup()
    elseif (index(['vim','help'], &filetype) >= 0)
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

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Remap keys for applying codeAction to the current line.
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

xmap <localleader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" }}}
" Pretier {{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <localleader>f <Plug>(coc-format-selected)
nmap <localleader>f <Plug>(coc-format-selected)
let g:which_local_key_map.f = 'format-selected'
" }}}
" Git {{{
" Use `[g` and `]g` to navigate git chunks
nmap <silent> [g <Plug>(coc-git-prevchunk)
nmap <silent> ]g <Plug>(coc-git-nextchunk)
nnoremap <localleader>gm :diffget //3<CR>
" }}}
" Matchit {{{
" Use Tab instead of % to switch
nmap <Tab> %
vmap <Tab> %
" }}}
" Markdown {{{
au FileType markdown packadd markdown-preview.nvim
" }}}
" FZF {{{
let g:fzf_layout = { 'window': {'width': 0.9, 'height': 0.6}}
" }}}
" {{{ Omnisharp
let g:OmniSharp_server_stdio = 1
let g:omnicomplete_fetch_full_documentation = 1
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_typeLookupInPreview = 1
set previewheight=5
" }}}
let g:svelte_preprocessors = ['typescript']
