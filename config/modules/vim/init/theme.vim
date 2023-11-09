" Detect dark / light mode from system
" let darkmode=split(system('defaults read -g AppleInterfaceStyle'))
" if len(darkmode) > 0 && tolower(darkmode[0]) == 'dark'
"   let darkmode=1
" else
"   let darkmode=0
" endif

" syntax enable
" if darkmode == 0
"   set background=light
"   let g:airline_theme = 'catppuccin_latte'
"   colorscheme catppuccin_latte
"   " colorscheme dayfox
" else
"   set background=dark
"   let g:airline_theme = 'catppuccin_mocha'
"   colorscheme catppuccin_mocha
"   " colorscheme nordfox
" endif

