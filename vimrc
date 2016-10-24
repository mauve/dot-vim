set nocompatible

" Load pathogen
call pathogen#infect()

" Plugin settings
filetype plugin on

" Indentation
set copyindent
set preserveindent
set shiftround
set expandtab
set smarttab

" Searching
set hlsearch
set ignorecase
set smartcase

" Display
set colorcolumn=80,120
set nowrap
set scrolloff=10
set sidescroll=1
set sidescrolloff=20
set title
let g:signify_sign_change = '±'

" Folds
set foldmethod=syntax
set foldlevelstart=99

" Keys
let mapleader=","

" Colors and color hacks
if has("gui_running")
  set background=light
  set guifont=M+\ 1mn\ 11
  colorscheme solarized
else
  set t_Co=256
  set background=dark
  let g:solarized_contrast="high"
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  colorscheme solarized
  highlight LineNr ctermbg=235
  highlight SignColumn ctermbg=235
end
let g:solarized_hitrail=1

if has("gui_running")
  " use X Clipboard
  set clipboard=unnamedplus
else
  " don't copy visual selections
  set clipboard-=autoselect
end

" Enable automatic indent detection
autocmd BufReadPost ** :DetectIndent
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4

let g:SuperTabNoCompleteAfter = ['^', '\s', '[,;]']

" Enable spell checking for git commits, texts
autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG setlocal spell
autocmd BufNewFile,BufRead *.{rst,md,markdown,txt} setlocal spell
autocmd BufNewFile,BufRead README* setlocal spell

" NERDtree stuff
function! NerdTreeFindOrToggle()
  if -1 == match(expand('%'), 'NERD_Tree')
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
map <C-n> :call NerdTreeFindOrToggle()<CR>

" Close NERDtree if it is the last remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Syntastic: Use make for C
let g:syntastic_c_checkers = ['make']

" airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '▒'
let g:airline_right_sep = '▒'
let g:airline_section_y = ''
let g:airline_symbols.crypt = '🔑 '
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'PASTE'
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = '␣'

" VCS hunk text objects
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
