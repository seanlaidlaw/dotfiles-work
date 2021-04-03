" set file encoding to avoid listchar errors in linux
scriptencoding utf-8
set encoding=utf-8

" Plugin Management
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify' " starter page with links to recent files


" themes
Plug 'chriskempson/base16-vim' " 256 color theme
Plug 'reedes/vim-colors-pencil', { 'on':  'PencilSoft' } "vim pencil theme
Plug 'ryanoasis/vim-devicons' " icons in nerdtree and starterpage

" writing
Plug 'ferrine/md-img-paste.vim', { 'for':  'md' } " allows <leader>p to paste an image into vim
Plug 'reedes/vim-pencil', { 'on':  'PencilSoft' } "IA writer like environment for non-code writing

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'scrooloose/nerdcommenter' " keyboard shorcut for easy comments
Plug 'tpope/vim-fugitive'	" git in vim
Plug 'neworld/vim-git-hunk-editor'
Plug 'kshenoy/vim-signature' " show marks in sidebar

" Nvim-R
Plug 'jalvesaq/Nvim-R', { 'for':  'R' }

" Add premade Snippets
Plug 'honza/vim-snippets'

" Easymotion
" press ,<leader><leader> then a movement key to show hints to move cursor
Plug 'easymotion/vim-easymotion' " press <leader><leader> to

" FZF in vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Terminal managment
Plug 'voldikss/vim-floaterm' " floating terminal inside vim
Plug 'benmills/vimux', { 'on': 'VimuxRunCommand' } " Tmux interaction

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Autorun line by line and show result
"Plug 'metakirby5/codi.vim', { 'for': 'python' }


Plug 'darfink/vim-plist', { 'for': 'plist' }

" underline letters to seek to
Plug 'unblevable/quick-scope'

" color code highlighter
Plug 'lilydjwg/colorizer'

" <leader>gu to show undo/redo history tree
Plug 'sjl/gundo.vim', { 'on':  'GundoToggle' }

"run ,td or :TaskList to show all todos
Plug 'vim-scripts/TaskList.vim', { 'on':  'TaskList' }

" minimalist writing experience
Plug 'junegunn/goyo.vim', { 'on':  'Goyo' }


" All of your Plugins must be added before the following line
call plug#end()

" allow plugin and syntax again
filetype plugin indent on    " required



"""""""""""""""""""""""""""""""
"         APPEARANCE          "
"""""""""""""""""""""""""""""""
syntax on
set background=dark

set list	" show invisible characters
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" don't show statusbar or commandline
set laststatus=0
set noshowmode

" this let base16colorspace=256 needs to be BEFORE colorscheme declaration
let base16colorspace=256
colorscheme base16-tomorrow-night-eighties
hi Normal guibg=NONE ctermbg=NONE

" enable treesitter syntax highlighting, as it  highlights
" way more things that normal vim colors the same
if has('nvim')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {enable = true},
}
EOF
endif

"""""""""""""""""""""""""""""""
"           GENERAL           "
"""""""""""""""""""""""""""""""
set relativenumber number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=0	" Line wrap (number of cols), 0 means never hard breaks the line
set showmatch	" Highlight matching brace
set matchpairs+=<:> "add <> as a matchpair as its not included by default

" Set MacVim / GUI font and size
set guifont=Operator\ Mono\ Lig\ Book:h14

" Search within search if visual selection
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
set wrapscan	" Searches wrap around end of file


" Set leader to be ',' as '/' is hard to reach on EU keyboards
let mapleader=","

set mouse=i	" Allow mouse in insert mode
set autoindent	" Auto-indent new lines
set smarttab	" Enable smart-tabs
set shiftround " round indent to a multiple of 'shiftwidth'
set noexpandtab		" use tabs not spaces
" for tabs to work these need to be the same
set shiftwidth=4	" Number of auto-indent spaces
set tabstop=4	" Number of spaces per Tab

set autochdir	" Change working directory to open buffer

"set vim buffer to clipboard
set clipboard=unnamed
set backspace=indent,eol,start	" Backspace behaviour

" don't redraw while executing macros (better performance)
set lazyredraw

" No annoying sound on errors
set noerrorbells
set novisualbell

" escape key is hard to reach
inoremap jk <Esc>
inoremap kj <Esc>

" Replace all is aliased to S.
nmap S :%s//g<Left><Left>
vmap S :s//g<Left><Left>

" Opposite of J to split lines
nnoremap <leader>k r<Enter>

" Replace word under cursor with clipboard
map <leader>cw ve"0px

" press gm to go to mark (` is hard to press on my keyboard)
nmap gm `

" TAB and Shift-TAB in normal mode cycle buffers
nmap <Tab> :bn<CR>
nmap <S-Tab> :bp<CR>

" close buffer on ZZ not all of vim (unless only one buffer)
nmap ZZ :call CloseBuffer()<cr>
function! CloseBuffer()
  let num_buffers = len(getbufinfo({'buflisted':1}))
  if (num_buffers == 1)
	  x
  else
	  w|bd
  endif
endfunction



" allow indenting of code blocks without losing selection each time
vnoremap < <gv
vnoremap > >gv

" how many lines of history vim should keep
set hidden
set history=10000

" Turn persistent undo on , so can undo even when you close a buffer
if !isdirectory($HOME."/.vim")
	call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim-undo-dir")
	call mkdir($HOME."/.vim-undo-dir", "", 0700)
endif
set undodir=~/.vim-undo-dir
set undofile
set undolevels=10000

" Always use vertical diffs
set diffopt+=vertical

" Folding
set foldenable " enable folding
set foldmethod=manual
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold Max

" space open/closes folds
nnoremap <space> za

" save session : saves windows and locations. Reopen with "nvim -S"
nnoremap <leader>s :mksession<CR>

" get out of neovim :terminal using Esc
tnoremap <Esc> <C-\><C-n>

" save folds
"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent! loadview
"augroup END

" Fast saving
nnoremap <leader>w :w!<cr>

" quick quit
nmap zz <Esc>ZZ

" disable Ex mode
nnoremap Q <Nop>

" auto commands on save
" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e
" automatically organizes Go imports on save
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" enter vim at same place you left
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



"""""""""""""""""""""""""""""""
"      SPELL CHECK            "
"""""""""""""""""""""""""""""""
map <F6> :setlocal spell! spelllang=en_gb<CR>
map <F7> :setlocal spell! spelllang=fr<CR>
" Cntrl-l sets the first suggested spelling for the incorrect word that is
" next after the cursor, but can be undone by pressing <Esc>u
imap <c-l> <c-g>u<Esc>]s1z=`]a<c-g>u
" Cntrl-b is easier to reach than esc-u
imap <c-b> <Esc>uei
" zg adds word as "good word" in spell file
" zw adds word as "wrong word" in spell file


"""""""""""""""""""""""""""""""
"      SURROUND WORDS         "
"""""""""""""""""""""""""""""""
" ," Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>

" <leader>' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>
" <leader>) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>) c( <C-R>" )<ESC>
vmap <leader>( c(<C-R>")<ESC>

" <leader>[ Surround a word with [brackets]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>

" <leader>{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

map <leader>` ysiw`
map <leader>_ ysiw_


""""""""""""""""""""""""""""""
"    WINDOWS MANAGEMENT
""""""""""""""""""""""""""""""

" These move to the window in the direction chosen
" if it doesn't exist then it makes a split there
map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction


" Navigating with guides
inoremap <leader><Tab> <Esc>/<++><Enter>"_c4l

" File shortcuts
" Open my bibliography file in split
nnoremap <leader>eb :vsp<space>$QUTE_BIB_FILEPATH<bar>set syntax=bib<CR>

" Open current filetypes snippets in split
function! SnippetEdit()
	let myft = &filetype
	execute 'vsp $dotfiles/vim/ultisnips/' . myft . '.snippets'
endfunction
nnoremap<leader>nn :call SnippetEdit()<CR>


" Open my vimrc in split
nnoremap<leader>evv :vsp<space>~/.vimrc<CR>

" source .vimrc
nnoremap <leader>zz :source ~/.vimrc<cr>


" insert template text on creating new some filetypes
augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python3\<nl># -*- coding: utf-8 -*-\<nl>\"|$
	autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
	autocmd BufNewFile *.r 0put =\"#!/usr/bin/env Rscript\<nl>\"|$
	autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$

	" for new marp.md file: auto read template and start marp server in template directory
	autocmd BufNewFile *.marp.md r ~/Templates/marp/template.marp.md | w| !marp --server --preview --config-file ~/Templates/marp/marp.config.js "$(greadlink -f "$(dirname %)")" &
	autocmd BufRead *.marp.md !marp --server --preview --config-file ~/Templates/marp/marp.config.js "$(greadlink -f "$(dirname %)")" &
	autocmd BufRead *.md setlocal textwidth=79

	" for new Rmd file: auto copy citation style to directory
	"read template into buffer, and hard link Qutebrowser bibliography to current folder
	autocmd BufNewFile *.Rmd r ~/Templates/Rmarkdown/university_paper.Rmd |!cp ~/Templates/Rmarkdown/sll-citation-style.csl "$(greadlink -f $(dirname %))"; ln ~/.qutebrowser_bibliography mybibliography.bib
	autocmd BufNewFile *.go r ~/Templates/go/example.go
	" for new cython file: auto copy example cython files to directory
	autocmd BufNewFile *.pyx r ~/Templates/cython/example.pyx |!cp ~/Templates/cython/setup.py "$(greadlink -f $(dirname %))";cp ~/Templates/cython/execute_cython.sh "$(greadlink -f $(dirname %))";cp ~/Templates/cython/run_cython_fct.py "$(greadlink -f $(dirname %))"
	autocmd BufNewFile *.cpp r ~/Templates/cpp/basic_cpp_template.cpp
	autocmd BufNewFile *.beamer r ~/Templates/Rmarkdown/red_cambridgeus.beamer
	autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END


" insert template text on creating new some filetypes
augroup FiletypeMacros
	autocmd FileType python nnoremap <C-P> vEyopa)0iprint(0
	autocmd FileType python nnoremap <C-t> vEy0Pa = 0
	autocmd FileType sh nnoremap <C-P> veyopa"0iecho "$0
	autocmd FileType sh nnoremap <C-t> vEy0Pa = 0
	autocmd FileType go nnoremap <C-P> vEyopa)0ifmt.Println(0

	" execute current file in floating terminal
	autocmd FileType python nmap <leader>w :w!\|FloatermNew --autoclose=0 python %<cr>
	autocmd FileType sh nmap <leader>w :w!\|FloatermNew --autoclose=0 bash %<cr>
	autocmd FileType go nmap <leader>w :w!\|FloatermNew --autoclose=0 go run % testproj<cr>
augroup END





""""""""""""""""""""""""""""""
"     PLUGIN SETTINGS        "
""""""""""""""""""""""""""""""
" Fugitive Plugin Settings
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gd :Gdiff<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>
nmap <silent><leader>gc :Git commit<cr>
vnoremap <silent><leader>g- :'<,'>diffput<cr>
vnoremap <silent><leader>g= :'<,'>diffget<cr>

" vim-git-hunk-editor settings
nnoremap <F11> :HunkLineToggle<cr>

" gundo (revision of history saving)
map <leader>gu :GundoToggle<CR>
let g:gundo_width = 30
let g:gundo_preview_height = 15
let g:gundo_right = 1
" vim with python2 can break python3 support
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" tasklist
map <leader>td <Plug>TaskList

" NerdCommenter settings
let g:NERDCustomDelimiters = {
	\ 'rmd' : { 'left': '<!-- ','right': ' -->' },
	\ 'beamer' : { 'left': '<!-- ','right': ' -->' }
	\ }

" ALE Settings
nnoremap <F8> :ALEToggle<CR>
inoremap <F8> <esc>:ALEToggle<CR>a
" Set flake8 as python linter and autopep8 as python fixer
let g:ale_fixers = {'python': ['autopep8']}
let g:ale_linters = {'python': ['flake8']}

" Goyo
let g:pencilgoyo_status=0
nnoremap <F10> :call PencilGoyo()<CR>
function! PencilGoyo()
	if g:pencilgoyo_status == 0
		set wrap nolinebreak nolist
		set background=light
		colorscheme pencil
		:PencilSoft
		:Goyo
		let g:pencilgoyo_status=1
	else
		:Goyo
		:PencilOff
		set background=dark
		colorscheme base16-eighties
		set list linebreak
		let g:pencilgoyo_status=0
	endif
endfunction

" Easy select and copy from terminal
" this removes line numbers and indent symbols
let g:select_mode_status=0
nnoremap <F3> :call SelectModeToggle()<CR>
function! SelectModeToggle()
	if g:select_mode_status == 0
		set wrap nolinebreak nolist
		set relativenumber! number!	" hide line numbers
		set showbreak=
		set signcolumn=no " hide marks column
		let g:select_mode_status=1
	else
		set list linebreak
		set relativenumber number	" Show line numbers
		set showbreak=+++	" Wrap-broken line prefix
		set signcolumn=yes " show marks column
		let g:select_mode_status=0
	endif
endfunction
" vim markdown <leader>p to paste img on clipboard
nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

" Nvim-R settings
let maplocalleader = ','
command! RStart let oldft=&ft | set ft=r | exe 'set ft='.oldft | let b:IsInRCode = function("DefaultIsInRCode") | normal <LocalLeader>rf
if &diff
else
	au BufReadPost,BufNewFile *.r,*.R,*.Rmd normal ,rf
endif

nmap <Space> <Plug>RDSendLine
vmap <Space> <Plug>RDSendSelection
nmap <LocalLeader>cl <Plug>RClearAll
nmap <LocalLeader>ll <Plug>RNLeftPart


let g:codi#interpreters = {
	\ 'python': {
		\ 'bin': 'python3',
		\ 'prompt': '^\(>>>\|\.\.\.\) ',
		\ },
	\ }



" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" you can exit out of these windows by pressing <c-c>
nnoremap <C-b> :BLines<CR>
nnoremap <C-m> :Marks<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" something was blocking this meaning vimrc had to be resourced for this to
" work until i put it towards the bottom
" Disable highlight when <leader><cr> is pressed
nnoremap <leader><space> :noh<cr>

" Easymotion settings, remap leader to spacebar
nmap <space> <Plug>(easymotion-prefix)

" Floaterm settings
"  easy toggle window with <F2>
nnoremap <F2> :FloatermToggle<cr>
tnoremap <F2> <C-\><C-n>:FloatermToggle<cr>

" close terminal window on shell exit
let g:floaterm_autoclose=1
let g:floaterm_wintitle=0

"""""""""""""""""""""""""""""""
""   AUTOCOMPLETE SETTINGS    "
"""""""""""""""""""""""""""""""

let g:coc_global_extensions = [
\ 'coc-css',
\ 'coc-html',
\ 'coc-json',
\ 'coc-markdownlint',
\ 'coc-r-lsp',
\ 'coc-sh',
\ 'coc-snippets',
\ 'coc-syntax',
\ 'coc-vimlsp',
\ 'coc-vimtex',
\ 'coc-yaml',
\ ]

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Always show the signcolumn, otherwise it would shift the text each time
" a new mark is added
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
