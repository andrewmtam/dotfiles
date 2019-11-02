let $FZF_DEFAULT_COMMAND = 'git ls-files'

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'

" color
Plug 'morhetz/gruvbox'

" JS Syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'moll/vim-node'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" File navigation
" Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'

" typescript
Plug 'Quramy/tsuquyomi'

" autocomplete
"Plug 'Shougo/echodoc.vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Tern isn't really working
"Plug 'carlitux/deoplete-ternjs'
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" syntax checking
"Plug 'w0rp/ale'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'

Plug '~/Developer/vim/path.vim'

" Replaces ctrlp
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


"I don't really use tags either
"Plug 'ludovicchabant/vim-gutentags'
"

" Display CTags
" I don't need / use this
" Plug 'majutsushi/tagbar'
"

" Show vim tabs
" Plug 'vim-airline/vim-airline'


" Workspaces - controlled bufferes per tab!
Plug 'vim-ctrlspace/vim-ctrlspace'

" Plug 'mtth/scratch.vim'

call plug#end()


" Override Rg to support directory
" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
"command! -bang -nargs=* Rg
"  \ call fzf#vim#grep(
"  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"  \   <bang>0 ? fzf#vim#with_preview('up:60%')
"  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"  \   <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>).' printing e2e-tests client client-common js', 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)



"""""""""""""""""""
"
" Plugin Config
"
"
"""""""""""""""""""
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_tabs = 0
" " let g:airline#extensions#tabline#buffer_idx_mode = 1
" " let g:airline#extensions#tabline#buffer_nr_show = 1
" " let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#gutentags#enabled = 1
" let g:airline#extensions#ctrlspace#enabled = 1
"
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}




let g:ackprg = 'ag --vimgrep'
" Write this in your vimrc file
" let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0
"let g:ale_linters = {'javascript': ['eslint', 'stylelint']}
"let g:ale_fixers = {'javascript': ['prettier'], 'typescript': ['prettier']}
"command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

"let g:ale_linter_aliases = {'javascript': 'css'}
"let g:ale_pattern_options = {
"\   'client/src/scripts/legacy-modules/.*$': {'ale_fixers': [], 'ale_linters': ['jshint']},
"\}
"let g:ale_fix_on_save = 1

let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

let g:gutentags_ctags_exclude = ['node_modules']

let g:CtrlSpaceDefaultMappingKey = "<C-space> "
" let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
" let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"

let g:coc_node_path = "/Users/andrewtam/.nvm/versions/node/v10.15.3/bin/node"
let g:scratch_insert_autohide = 0
let g:scratch_autohide = 0

"""""""""""""""""""
"
" Plugin Alias
"
"
"""""""""""""""""""
"map \| :TagbarToggle<CR>


" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap f <Plug>(easymotion-overwin-f2)

"""""""""""""""""""
"
" Misc Config
"
"
"""""""""""""""""""

" https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
au FocusGained,BufEnter * :silent! !
" au FocusLost,WinLeave * :silent! w

" Turn on filetype plugin
filetype plugin on

" Copy vim clipboard to system clipboard
set clipboard=unnamedplus

" https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file
set hidden

" For vim-ctrlspace
set nocompatible
set showtabline=0



" https://medium.com/@sidneyliebrand/how-fzf-and-ripgrep-improved-my-workflow-61c7ca212861
nnoremap <C-p> :GFiles<Cr>
imap <C-f> <plug>(fzf-complete-path)



nnoremap <C-f> :Rg! 


" http://spf13.com/post/perfect-vimrc-vim-config-file

" Automatically open up vim files that are already open
set autoread

" Show trailing and preceding spaces
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

set notimeout          " don't timeout on mappings
set ttimeout           " do timeout on terminal key codes
set timeoutlen=100     " timeout after 100 msec

" Search case-sensitive if search has caps in it
set ignorecase
set smartcase

" allow to access one character past last one
set virtualedit=onemore

" Show the line numbers
set number

" Show position and line number of cursor
set ruler

" Set the colorscheme
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

"colorscheme relaxedgreen 
"colorscheme candycode
"colorscheme desert
"highlight LineNr ctermfg=blue
" highlight Comment ctermfg=greya
"highlight Normal  ctermbg=Black
"highlight CocFloating ctermfg=darkred


" Set a different colorscheme when vimdiffing 
" au FilterWritePre * if &diff | colorscheme wombat | endif

" Don't have curser scroll to end of window
set scrolloff=5

" Set tab spacing
set expandtab
set tabstop=4
set shiftwidth=4

" Be smart when using tabs ;)
" This clears tabs when you back space, after smart tabbing
set smarttab
" Automatically starts the next line at the same tab spacing
"set ai "Auto indent
" Tries to align braces and such
"set si "Smart indent


" Allow backspacing over indent, eol, start
set backspace=indent,eol,start

" Shows how many lines are selected in visual mode.
set showcmd

" On tab filename complete, first tab produces longest. Second tab produces list.
set wildmode=longest,list

set complete-=i

" Set 7 lines to the cursor - when moving vertically using j/k
set so=10

" Always show the status line
set laststatus=2

" When opening tabs from commandline, there is a  limit
set tabpagemax=100

" Format the status line
" set statusline=%{fugitive#statusline()}\ " git repo
" set statusline=%<%f                             " Filename
" set statusline+=%w%h%m%r                        " Options
" set statusline+=\ [%{&ff}/%Y]                   " filetype
" set statusline+=\ [%{getcwd()}]                 " current dir
" set statusline+=\ [A=\%03.3b\ H=\%02.2B]        " ASCII / hexadecimal value of char
" set statusline+=%h%=\ Char:\ %c\ \ Line:\ %l/%L\ %P " Character and line count

" https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/
let g:omni_sql_no_default_maps = 1
let g:loaded_sql_completion = 0

"""""""""""""""""""
"
" Misc Alias
"
"
"""""""""""""""""""
" remap the semicolon to colon to enter functions
nnoremap ; :

" Lets you scroll to wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap <up> gk
nnoremap <down> gj

nmap q: <Nop>


" Remapping this because of the matchtag
" nnoremap $ %

inoremap <C-c> <ESC>
nnoremap <C-c> :nohl<CR>

" Copy filename to clipboard
nnoremap FF :let @*=expand("%:p")<CR><C-G>

" Copy filename to clipboard
nnoremap Ff :call MakeRelativePath()<CR>

" Change functionality of # and * search
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap * :let @/='<C-R>=expand("<cword>")<CR>'<CR>:set hls<CR>
nnoremap # :let @/='<C-R>=expand("<cword>")<CR>'<CR>:set hls<CR>

" Command line navigation
cmap <C-a> <C-b>

" In insert mode, type ctrl + k, and then any character and vim will tell you
" if a remap exists for it

" Automatically change current working directory to most recent file
"set autochdir

" In terminal mode, use <ESC> to quit
"tnoremap <Esc> <C-\><C-n>

" Adds brackets to match pairs (only does braces right now)
"set matchpairs+=<:>

" Remap diff all command
command! Diff Gvdiff HEAD|windo set wrap

" Remap diff all command
"command! DiffAll tabdo Gvdiff HEAD|tabdo windo set wrap

"command Diff tabdo Gvdiff
"command! Gadd !git add %

" For git commits, always start cursor at first position
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" https://codeyarns.com/2015/02/02/cannot-close-buffer-of-netrw-in-vim/
autocmd FileType netrw setl bufhidden=wipe

" " automatically reload vimrc when it's saved
" augroup AutoReloadVimRC
"     au!
"     au BufWritePost $MYVIMRC so $MYVIMRC
" augroup END


" set statusline=%{fugitive#statusline()}\ %{HasPaste()}%F%m%r%h\ %w\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ \ CWD:\ %r%{getcwd()}%h%=Char:\ %c\ \ Line:\ %l/%L\ %P
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P


" vim-fugitive
" Remapped <CR> to O to open all things in new tabs when you hit enter on them
" See source code for this change
"
"
"
"
"
"
"
"
"
"
"
" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
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

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Use <c-c> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
""inoremap <expr> <C-c> pumvisible() ? "\<C-y>\<C-c>" : "\<C-c>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
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
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" map <C-m> :NERDTreeFind<CR>


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

command! -nargs=+ -complete=custom,s:GrepArgs Ag exe 'CocList --nomral grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Using CocList
" Show all lists 
nnoremap <silent> <space>l  :<C-u>CocList --normal lists<cr>
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList --normal diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList --normal extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList --normal commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList --normal outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList --normal -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Ctrl P Eqiuovalent
" "nnoremap <silent> <C-p>  :<C-u>CocList files<cr>

nnoremap <silent> P :Ag
