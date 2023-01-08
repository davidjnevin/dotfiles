set exrc " pick up local .vimrc if exits
set guicursor =  " leave the cursor as a block
set encoding=utf-8
set colorcolumn=88
set foldenable
set foldmethod=indent

" Vim-plug initialization

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')

if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

call plug#begin("~/.vim/plugged")

" PlantUml
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" Run tests
Plug 'vim-test/vim-test', { 'for': ['python'] }
Plug 'tpope/vim-dispatch' " asynchronous

" Code snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Conquer of Completion
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color scheme
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'

" Code commenter
Plug 'scrooloose/nerdcommenter'
Plug 'flazz/vim-colorschemes'

" Better motion
Plug 'easymotion/vim-easymotion'

" Class/module browser
Plug 'majutsushi/tagbar'

" Dockerfile Syntax
Plug 'ekalinin/Dockerfile.vim'

Plug 'https://github.com/nathanaelkane/vim-indent-guides'

Plug 'https://github.com/machakann/vim-highlightedyank'

Plug 'https://github.com/junegunn/goyo.vim'

Plug 'diepm/vim-rest-console'

Plug 'https://github.com/hashivim/vim-terraform.git'

Plug 'https://github.com/tweekmonster/django-plus.vim'

Plug 'https://github.com/pangloss/vim-javascript'

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'cespare/vim-toml', { 'branch': 'main' }

" Asynchronous Lint Engline
Plug 'dense-analysis/ale'

" Docstring Generator
Plug 'yaegassy/coc-pydocstring', {'do': 'yarn install --frozen-lockfile'}

" Vim case changer
Plug 'arthurxavierx/vim-caser'

" Yaml-Vim
Plug 'mrk21/yaml-vim'

call plug#end()

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

fu! ConfigurePyDocString()
    " choice[pydocstring_formatter] = sphinx, numpy, google
    let g:pydocstring_formatter = 'numpy'
    nmap <silent> ga <Plug>(coc-codeaction-line)
    xmap <silent> ga <Plug>(coc-codeaction-selected)
    nmap <silent> gA <Plug>(coc-codeaction)
endfunction

call ConfigurePyDocString()
" The Silver Searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

" Spell check syntax highliting
let g:gruvbox_guisp_fallback = "bg"

"needed for italics, only works in some terminals
let g:gruvbox_italic=1
"change to the change coloursheme to whatever I prefer at the time
colorscheme gruvbox
set background=dark

"hide the options in gvim
set guioptions=aci

"spelling
set nospell
setlocal spell spelllang=en_us
setlocal nospell
set complete+=kspell

" Security options
set nomodeline

" Don't mark word_word as a markdown error
hi link markdownError Normal

" pymode
" This stops that stupid error window popping up everywhere on every buffer
let g:pymode_lint_cwindow = 0

set nocompatible

if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

set hidden

set wildmenu

set showcmd

set hlsearch


let &directory = expand('~/.vimdata/swap//')

set undofile
let &undodir = expand('~/.vimdata/undo//')

if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif

" how to split windows
set splitbelow
set splitright

au VimResized *:wincmd = " resize splits when windows are reduced

" show cursor line
set cursorline

" show signcolum for errors etc.
set signcolumn=yes

augroup davidjnevin
  "" delete any old autocommand
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" use 256 colors when possible

" colorscheme base16-monokai
colorscheme gruvbox
set background=dark
set t_Co=256
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set wildmenu

" when scrolling, keep cursor 5 lines away from screen border
set scrolloff=5

" save as sudo
cmap w!! w !sudo tee "%"

" search
set incsearch " incremental search
set ignorecase " search is case insensitive but you can add \C to make it sensitive
set smartcase " will automatically switch to a case-sensitive search if you use any capital letters

" persistent undo between sessions
set undofile

" Useful for yml and python

autocmd Filetype python set cursorcolumn

" smart wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

" keybindings
" <CR> is a carrige return
" remove seach highlighting
nnoremap <leader>nh :noh<CR>

" Goyo comfortable writing mode
nnoremap <leader>gg :Goyo<CR>

" Turn on and off spelling
nnoremap <leader>sp :setlocal spell!<CR>

" Yank and Paste from System clipboard too
nnoremap <leader>Y "*y
nnoremap <leader>P "*p

" Reset Vim syntax highlighting
nnoremap <leader>sh <ESC>:syntax sync clear<CR>

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
" Enable use of the mouse for all modes if has('mouse')
if has('mouse')
  set mouse=a
endif

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number
set relativenumber

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Indentation options {{{1

" Indentation settings for using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4

set list
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

augroup html_files
    autocmd!
    autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=99
augroup END

augroup html_handlebars
    autocmd!
    autocmd FileType html.handlebars setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=99
augroup END

augroup css_files
    autocmd!
    autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=99
    autocmd FileType scss setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=99
augroup END

augroup filetype_yaml
    autocmd!
    autocmd BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
    autocmd FileType yaml |
        setlocal shiftwidth=2 |
        setlocal softtabstop=2 |
        setlocal tabstop=2
augroup END

augroup filetype_python


" Linters ALE
let g:ale_linters = {'python': ['flake8', 'pydocstyle', 'bandit', 'mypy'],'markdown': ['vale'], 'text':['vale'], 'yaml': ['yamllint'] }
" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" Disable linters on opening a file
let g:ale_lint_on_enter = 0


let g:ale_fixers = {'*': [], 'python': ['black', 'isort']}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

"------------------------------------------------------------
" Mappings

let mapleader=' '
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Map <C-P> to files for fuzzy searching
nnoremap <C-P> :GFiles<CR>

" quit file
"nnoremap <leader>q <esc>:q<cr>

" go to normal mode. amazing!!
inoremap kj <esc>l

" move between windows
nnoremap <TAB><TAB> <C-w><C-w>

" do nothing when F1 is pressed
noremap <F1> <nop>
inoremap <F1> <nop>

" key mapping for save file
nnoremap <F2> <esc>:w<CR>
inoremap <F2> <esc>:w<CR>
vnoremap <F2> <esc>:w<CR>

" tab navigation mappings
nnoremap tn :tabn<CR>
nnoremap tp :tabp<CR>
nnoremap tt :$tabnew<CR>

" move text lines and blocks
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" reselect text after indentation
vnoremap < <gv
vnoremap > >gv
nnoremap > <c-w>>
nnoremap < <c-w><

" override next and previous search to show in the middle of the screen (zz)
" and also open just enough folds (zv) to make the line in which the cursor
" is located not folded.
nnoremap n nzzzv
nnoremap N Nzzzv
" ============================
" Plugins configuration
" ============================

" NERDTree ------------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <F4> :NERDTreeFind<CR>
" dont show this files
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__', '\venv']
" show cursor line
let NERDTreeHighlightCursorline = 1

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" Ariline -------------------------------
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" Fuzzy finder -------------------------
nnoremap <leader>e :GFiles<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>m :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>W :Windows<CR>

"command! -bang -nargs=? -complete=dir Files
    "\ call fzf#vim#files(<q-args>, {'options': ['--preview', '--info=inline']}, <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" Airline Settings
" enable list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#formatter = 'default'

" Show ALE errors in the statusline
let g:airline#extensions#ale#enabled = 1



" Tagbar ------------------------------"
let g:tagbar_compact = 1
let g:tagbar_sort = 1
let g:tagbar_autoclose = 1
let g:tagbar_foldlevel = 0
let g:tagbar_width = 60
" open Tagbar
nnoremap <leader>t :TagbarToggle<CR>


" Jedi-vim ------------------------------

"let g:jedi#use_tabs_not_buffers = 1

" Rename
"let g:jedi#rename_command = '<leader>R'
" Go to definition
"let g:jedi#goto_command = '<leader>d'
" Find ocurrences
"let g:jedi#usages_command = '<leader>o'
" Find assignments
"let g:jedi#goto_assignments_command = '<leader>a'

" Vim tests -----------------------------

" run tests in a vim8 terminal
let g:test#strategy = "vimterminal"
let test#python#runner = 'pytest'

nmap <silent> <leader>rt :TestNearest<CR>
nmap <silent> <leader>rT :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rg :TestVisit<CR>

"Silver Searcher

nmap <silent> <RIGHT> :cnext<CR>
nmap <silent> <LEFT> :cprev<CR>

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-<tab>>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" COC Settings

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


