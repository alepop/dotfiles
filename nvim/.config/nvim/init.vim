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
    " call minpac#add('pechorin/any-jump.vim')
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
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.html :Format

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
" tnoremap <Esc> <C-\><C-n>
" tnoremap jk <C-\><C-n>
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
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
call which_key#register('<Space>', "g:which_key_map")
call which_key#register(',', "g:which_local_key_map")

let g:which_key_map =  {} " Define prefix dictionary
let g:which_local_key_map = {}
"
" Coc Search & refactor
nnoremap <leader>? :CocSearch <C-R>=expand("<cword>")<CR><CR>
let g:which_key_map['?'] = 'search word'

let g:which_key_map['/'] = [ ':call Comment()', 'comment' ]
let g:which_key_map['.'] = [ ':e $MYVIMRC', 'open init']
let g:which_key_map[';'] = [ ':Commands', 'commands' ]
let g:which_key_map['e'] = [ ':CocCommand explorer --quit-on-open --sources buffer-,file+', 'explorer']
let g:which_key_map['a'] = 'actions'
" }}}

" 'W' key (Windows) {{{
let g:which_key_map.w = {
            \ 'name' : '+windows' ,
            \ 'c' : ['<C-W>c'     , 'delete-window']         ,
            \ '-' : ['<C-W>s'     , 'split-window-below']    ,
            \ '|' : ['<C-W>v'     , 'split-window-right']    ,
            \ '=' : ['<C-W>='     , 'balance-window']        ,
            \ 'w' : [':Windows', 'windows'],
            \ }

" }}}

" 'B' key (Buffers) {{{
let g:which_key_map.b = {
            \ 'name': '+buffer',
            \ 'n': ['bnext', 'next-buffer'],
            \ 'p': ['bprevious', 'previous-buffer'],
            \ 'c': ['bunload', 'unload-buffer'],
            \ 'd': ['bdelete', 'delete-buffer'],
            \ 'b': ['Buffers', 'fzf-buffer'],
            \ }

" }}}

" 'L' key (LSP) {{{
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ '.' : [':CocConfig'                          , 'config'],
      \ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
      \ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
      \ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
      \ 'b' : [':CocNext'                            , 'next action'],
      \ 'B' : [':CocPrev'                            , 'prev action'],
      \ 'c' : [':CocList commands'                   , 'commands'],
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
      \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
      \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
      \ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
      \ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],
      \ 'O' : [':CocList -A --tab outline'                    , 'outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 'R' : ['<Plug>(coc-references)'              , 'references'],
      \ 's' : [':CocList -I symbols'                 , 'references'],
      \ 'S' : [':CocList snippets'                   , 'snippets'],
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'u' : [':CocListResume'                      , 'resume list'],
      \ 'U' : [':CocUpdate'                          , 'update CoC'],
      \ }
" }}}
" 'S' key (Search) {{{
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'              , 'history'],
      \ ';' : [':Commands'              , 'commands'],
      \ 'a' : [':Ag'                    , 'text Ag'],
      \ 'b' : [':BLines'                , 'current buffer'],
      \ 'c' : [':Commits'               , 'commits'],
      \ 'C' : [':BCommits'              , 'buffer commits'],
      \ 'f' : [':Files'                 , 'files'],
      \ 'g' : [':GFiles'                , 'git files'],
      \ 'G' : [':GFiles?'               , 'modified git files'],
      \ 'h' : [':History'               , 'file history'],
      \ 'H' : [':History:'              , 'command history'],
      \ 'l' : [':Lines'                 , 'lines'] ,
      \ 'm' : [':Marks'                 , 'marks'] ,
      \ 'M' : [':Maps'                  , 'normal maps'] ,
      \ 'p' : [':Helptags'              , 'help tags'] ,
      \ 'P' : [':Tags'                  , 'project tags'],
      \ 's' : [':CocList snippets'      , 'snippets'],
      \ 't' : [':Rg'                    , 'text Rg'],
      \ 'T' : [':BTags'                 , 'buffer tags'],
      \ 'y' : [':Filetypes'             , 'file types'],
      \ 'z' : [':FZF'                   , 'FZF'],
      \ }
" }}}
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

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
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
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = {'up':'~70%', 'window': { 'width': 0.9, 'height': 0.6,'yoffset':0.5,'xoffset': 0.5 } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"

let g:fzf_colors = {
\ 'fg': ['fg', 'Normal'],
\ 'bg': ['bg', 'Normal'],
\ 'hl': ['fg', 'Search'],
\ 'fg+': ['fg', 'Normal'],
\ 'bg+': ['bg', 'Normal'],
\ 'hl+': ['fg', 'DraculaOrange'],
\ 'info': ['fg', 'DraculaPurple'],
\ 'border': ['fg', 'Ignore'],
\ 'prompt': ['fg', 'DraculaGreen'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker': ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header': ['fg', 'Comment'] }

 " Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" }}}
" Functions {{{
function! Comment()
  if (mode() == "n" )
    execute "Commentary"
  else
    execute "'<,'>Commentary"
  endif
 endfunction
vnoremap <silent> <space>/ :call Comment()
" }}}
