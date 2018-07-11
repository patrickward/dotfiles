"""""""""""""""""""""""""""""""""""
" Vimrc Configuration
"""""""""""""""""""""""""""""""""""
set nocompatible                  " Must come first because it changes other options.
set encoding=utf8
let mapleader = ","

"""""""""""""""""""""""""""""""""""
" Vundle Configuration
"""""""""""""""""""""""""""""""""""
" Turn off filetype until after vundle and bundles
filetype off

" Set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'

" Utility
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'mileszs/ack.vim'
Plugin 'benmills/vimux'

" Theme / Colors
Plugin 'ap/vim-css-color'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Only enable if changing the tmuxline theme
" Plugin 'edkolev/tmuxline.vim'

" Git
Plugin 'tpope/vim-fugitive'

" Html / CSS
Plugin 'groenewege/vim-less'
Plugin 'mattn/emmet-vim'

" Markdown/Writing
Plugin 'lervag/vimtex'
Plugin 'tpope/vim-markdown'

" Ruby / Rails
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'

" PHP / Laravel
Plugin 'xsbeats/vim-blade'

" Python
Plugin 'glench/vim-jinja2-syntax'

" Elixir
Plugin 'elixir-editors/vim-elixir'

" Rust
Plugin 'rust-lang/rust.vim'

" Javascript
Plugin 'posva/vim-vue'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'mustache/vim-mustache-handlebars'

" Devops
Plugin 'chase/vim-ansible-yaml'

" End vundle
call vundle#end()

"""""""""""""""""""""""""""""""""""
" Configuration
"""""""""""""""""""""""""""""""""""

" Turn on file type detection.
filetype plugin indent on

" Turn on syntax highlighting.
syntax enable

" runtime macros/matchit.vim        " Load the matchit plugin.
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

" Intuitive backspacing. Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Enhanced command line completion.
set wildmenu

" Complete files like a shell.
set wildmode=list:longest

" fix default regex handling by using very magic by default
nnoremap / /\v
vnoremap / /\v

" Case-insensitive searching.
set ignorecase

" But case-sensitive if expression contains a capital letter.
set smartcase

" apply substitutions globally by default
set gdefault

" Highlight matches as you type.
set incsearch

" Highlight matches.
set hlsearch

nnoremap <leader><space> :noh<cr> " clear out highlighted searches (\space)

" Show line numbers.
set number

" Show cursor position.
set ruler

" Turn on line wrapping.
set wrap

" Wrap lines at the 'breakat' char rather than last char to fit on screen
set linebreak

" Show 3 lines of context around the cursor.
set scrolloff=3

" Set the terminal's title
set title

" No beeping.
set visualbell

" Don't make a backup before overwriting a file.
set nobackup

" And again.
set nowritebackup

" Keep swap files in one location
set directory=$HOME/.vim/tmp//,.

" always set autoindenting on
set autoindent

" copy the previous indentation on autoindenting
set copyindent

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
  autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab

  " Syntax for odd file extensions
  autocmd BufNewFile,BufRead *.chatito set syntax=markdown
  autocmd BufNewFile,BufRead *.chatito setlocal ts=4 sts=4 sw=4 expandtab

endif

" Strip trailing whitespace on save
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

" Use ripgrep for grep searches
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let g:ctrlp_user_command = 'rg --files %s'
    let g:ctrlp_use_caching = 0
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_switch_buffer = 'et'
endif

"""""""""""""""""""""""""""""""""""
" Interface
"""""""""""""""""""""""""""""""""""

" Show the status line all the time
set laststatus=2

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Fonts
set guifont=Meslo\ LG\ M\ for\ Powerline:h14
set linespace=2

" Set vim to 256 colors
set t_Co=256
set background=dark

" Access colors present in 256 colorspace
let base16colorspace=256
colorscheme base16-bright

" Used patched fonts for airline arrows/triangles
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#show_close_button=0
let g:airline_theme='base16_bright'

"""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""

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

" Open the current document with Marked.app
nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>

" Show word count of selection
nmap <leader>wc :!wc %<cr>

" PHPUnit Tests
" Run all tests
nmap <leader>ta :!clear && phpunit<cr>
" Run test on current test method
nmap <leader>tm yiw:!clear && phpunit --filter ^R"<cr>

" GCC Compile the file in the current buffer
" set makeprg=gcc\ -o\ %<\ %
" Make and run the current file in the buffer
nnoremap <silent> <f7> :make %< && ./%<<cr>

