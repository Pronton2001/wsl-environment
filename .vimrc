" set guifont=Cascadia\ Code\ PL \ 10
call plug#begin('~/.vim/plugged')
    Plug 'sheerun/vim-polyglot'

    Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
    Plug 'itchyny/lightline.vim'
    Plug 'preservim/nerdtree' 
    Plug 'Xuyuanp/nerdtree-git-plugin' "|
    "            \ Plug 'ryanoasis/vim-devicons'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Plug 'nvim-lua/popup.nvim'
    "Plug 'nvim-lua/plenary.nvim'
    "Plug 'nvim-telescope/telescope.nvim'

    "Search 
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'Yggdroot/indentLine'
    "or :set list lcs=tab:\|\ (here is a space)
    "Colorschemes

    "Base16 themes
    Plug 'chriskempson/base16-vim'         
    Plug 'gerw/vim-hilinktrace'
    " Plug 'fatih/molokai'                  " Monokai and friends
    " Plug 'crusoexia/vim-monokai'
    " Plug 'phanviet/vim-monokai-pro'
    Plug 'patstockwell/vim-monokai-tasty'
    " Plug 'erichdongubler/vim-sublime-monokai'
    " Plug 'flazz/vim-colorschemes'          " Bunch of color schemes
    Plug 'sainnhe/sonokai'                 " Monokai Pro-like scheme
    Plug 'tanvirtin/monokai.nvim'

    Plug '1612492/github.vim'
    "
    "Auto pair
    Plug 'jiangmiao/auto-pairs'

    "Mark down
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
"    Plug 'shime/vim-livedown' 

    "Python
    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    "Comment
    Plug 'preservim/nerdcommenter'
call plug#end()

set nocompatible

syntax on

" Spaces & Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" UI Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber
set cursorline
filetype indent on
filetype plugin on
set showmatch          
set autoindent
set smartindent
set backspace=indent,eol,start
set history=8192 
set scrolloff=12        " Keep cursor in approximately the middle of the screen
set linebreak           " Have lines wrap instead of continue off-screen
set splitbelow          " Open new vertical split bottom
set splitright 
set noerrorbells visualbell t_vb= " turn off bell
set mouse+=a
set encoding=UTF-8
set laststatus=2        " enable status line for lightline.vim
set updatetime=100      " Some plugins require fast updatetime
set ttyfast             " Improve redrawing
" Completion
" Better display for messages
set cmdheight=2
set nojoinspaces

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=iwhite " No whitespace in vimdiff
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

"Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set hlsearch
set smartcase " when search become case-sensitive if it contains any capital letters.
set incsearch " search during typing
"set nohlsearch

" turn off search highlight
vnoremap <C-e> :nohlsearch<cr>
nnoremap <C-e> :nohlsearch<cr>

" Ignore files for completion
set wildignore+=*/.git/*,*/tmp/*,*.swp

" Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
" nnoremap <space> za
set foldmethod=indent   " fold based on indent level
" This is especially useful for me since I spend my days in Python.
" Other acceptable values are marker, manual, expr, syntax, diff.
" Run :help foldmethod to find out what each of those do.

" =============================================================================
" # Keyboard shortcuts
" ============================================================================= 

" Suspend with Ctrl+f
"inoremap <C-f> :sus<cr>
"vnoremap <C-f> :sus<cr>
"nnoremap <C-f> :sus<cr>

" highlight last inserted text
nnoremap gV `[v`]
map <S-h> ^
map <S-l> $

" (Shift)Tab (de)indents code
vnoremap <Tab> >
vnoremap <S-Tab> <

" * FZF
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '~20%' }
nnoremap <C-p> :Files<CR>

" Quick-save
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>

" numbers
nnoremap <leader>1 1gt<CR>
nnoremap <leader>2 2gt<CR>
nnoremap <leader>3 3gt<CR>
nnoremap <Leader>4 4gt<CR>
nnoremap <Leader>5 5gt<CR>
nnoremap <Leader>6 6gt<CR>
nnoremap <Leader>7 7gt<CR>
nnoremap <Leader>8 8gt<CR>
nnoremap <Leader>9 9gt<CR>
nnoremap <leader>n :tabnew<CR>
nnoremap <Leader>x :tabclose<CR>

" move up down code
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
inoremap <leader>j <Esc>:m .+1<CR>==gi
inoremap <leader>k <Esc>:m .-2<CR>==gi
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv

" Resize windows
nnoremap <C-up> :resize +5 <CR>
nnoremap <C-down> :vertical resize +5<CR>

" tab completion for files/bufferss
" set wildmode=longest,list
" set wildmenu

" check if you code too far                                                 ->
set colorcolumn=80 
" <-
set signcolumn=yes

" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
"map <C-P> <Nop>
nmap Q <Nop>

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

let g:markdown_fenced_languages = [
    \ 'bash=sh',
    \ 'c',
    \ 'javascript',
    \ 'json',
    \ 'python',
    \ 'haskell',
\]

let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

let mapleader=' '
" nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>

if has('termguicolors')
    set termguicolors
endif

" for light version
" set background=light
" set contrast
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_italic_comment = 1

" for dark version
set background=dark
"colorscheme gruvbox-material
colorscheme sonokai

let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_better_performance = 1

" let g:lightline.colorscheme = 'gruvbox_material'
" let g:airline_theme = 'gruvbox_material'
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

let g:NERDTreeGitStatusUseNerdFonts = 1 " you should install nerdfonts by yourself. default: 0

"================================Coc-vim ===================================
"   To choose another background color 
highlight CocErrorFloat ctermfg=1
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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"inoremap <silent><expr> <c-@> coc#refresh()
"nmap <leader>rn <Plug>(coc-rename)    
"Use <cr> to confirm completion
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"To make <cr> select the first completion item and confirm the completion when no item has been selected:
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" To make coc.nvim format your code on <cr>:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif


"----------------------Plug 'Yggdroot/indentLine'---------------------------"

"Change Character Color
let g:indentLine_setColors = 0

let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char = 'c'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"-----------------------------------------------------------------------------
"coc-snippets
"-----------------------------------------------------------------------------
" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

"Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? coc#_select_confirm() :
"      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

" Markdown
set conceallevel=2

"""""""""""""""""""" Markdown """"""""""""""""""""
"nmap gm :LivedownToggle<CR>


"""""""""""""""""" Prettier """"""""""""""""""
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

""""""""""""" Comment  """""""""""""
nnoremap <silent> <leader>c} V}:call NERDComment('x', 'toggle')<CR>
nnoremap <silent> <leader>c{ V{:call NERDComment('x', 'toggle')<CR>

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle

""""""" Pymode  """""""
nmap <C-f> <nop>
let g:UltiSnipsExpandTrigger="^["
nmap <C-f> :PymodeLintAuto<CR>
