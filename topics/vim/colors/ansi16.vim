" vim/colors/ansi16.vim
hi clear
if exists('syntax_on') | syntax reset | endif
let g:colors_name = 'ansi16'
set t_Co=16
set notermguicolors        " forces cterm codes, so ghostty's active theme defines them

hi Normal       ctermfg=NONE ctermbg=NONE
hi Comment      ctermfg=8   cterm=italic
hi Constant     ctermfg=5
hi String       ctermfg=2
hi Identifier   ctermfg=6
hi Function     ctermfg=4   cterm=bold
hi Statement    ctermfg=1   cterm=bold
hi PreProc      ctermfg=5
hi Type         ctermfg=3
hi Special      ctermfg=6
hi Underlined   ctermfg=4   cterm=underline
hi Error        ctermfg=7   ctermbg=1
hi Todo         ctermfg=0   ctermbg=3

hi LineNr       ctermfg=8
hi CursorLineNr ctermfg=3   cterm=bold
hi CursorLine   ctermbg=0
hi Visual       ctermbg=8
hi Search       ctermfg=0   ctermbg=3
hi IncSearch    ctermfg=0   ctermbg=2
hi Pmenu        ctermfg=7   ctermbg=8
hi PmenuSel     ctermfg=0   ctermbg=4
hi StatusLine   ctermfg=0   ctermbg=4
hi StatusLineNC ctermfg=8   ctermbg=0
hi VertSplit    ctermfg=8   ctermbg=0
hi Directory    ctermfg=4
hi DiffAdd      ctermfg=2
hi DiffDelete   ctermfg=1
hi DiffChange   ctermfg=3
