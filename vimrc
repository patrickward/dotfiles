set nocompatible                  " Must come first because it changes other options.

let mapleader = ","

filetype off                      " Turn off filetype until after vundle and bundles

" setup vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Bundles
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-unimpaired'
Bundle 'kchmck/vim-coffee-script'
Bundle 'juvenn/mustache'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'johnhamelink/blade.vim'
Bundle 'ap/vim-css-color'
Bundle 'vim-scripts/bufexplorer.zip'


filetype plugin indent on         " Turn on file type detection.

syntax enable                     " Turn on syntax highlighting.

" runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing. Allow backspacing over everything in insert mode.

set hidden                        " Handle multiple buffers better. Hides buffers instead of closing them.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

" fix default regex handling by using very magic by default
nnoremap / /\v
vnoremap / /\v

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set gdefault                      " apply substitutions globally by default

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
nnoremap <leader><space> :noh<cr> " clear out highlighted searches (\space)

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set wrap                          " Turn on line wrapping.
set linebreak                     " Wrap lines at the 'breakat' char rather than last char to fit on screen
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set autoindent                    " always set autoindenting on
set copyindent                    " copy the previous indentation on autoindenting

" default indentation: 2 spaces
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

" set tabs and spaces based on filetype
if has("autocmd")

  " syntax for these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType snippet setlocal ts=4 sts=4 sw=4 noexpandtab

  " base style for certain languages
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType php setlocal ts=2 sts=2 sw=2 noexpandtab

endif

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" Show the status line all the time
set laststatus=2

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Or use vividchalk
" colorscheme vividchalk
set background=dark
" set background=light
colorscheme solarized

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Toggle 'set list' to show invisible characters
" and set the symbols to the sames ones as TextMate
nmap <leader>l :set list!<cr>
set listchars=tab:▸\ ,eol:¬

" retain visual selection after shifting right/left
" see: http://vim.wikia.com/wiki/Shifting_blocks_visually
vnoremap > >gv
vnoremap < <gv

" Uncomment to use Jamis Buck's file opening plugin
"map <Leader>t :FuzzyFinderTextMate<Enter>

" Controversial...swap colon and semicolon for easier commands
nnoremap ; :
"nnoremap : ;

vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" fold tag - sets folding for html tags
nnoremap <leader>ft Vatzf

" Map ,e and ,v to open files in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Switch between the last two files
nnoremap <leader><leader> <c-^>

"" Make the current window large, but leave others in context
"set winwidth=84
"" We have to have a winheight bigger than we want to set winminheight. But if
"" we set winheight to be huge before winminheight, the winminheight set will
"" fail.
"set winheight=5
"set winminheight=5
"set winheight=999

" Stylesheets for vim-preview
let g:PreviewCSSPath='/Users/patrick_ward/bin/dotvim/vim/stylesheets/github.css'

