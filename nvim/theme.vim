syntax enable
hi clear

" Editor
hi Normal           guifg=#F8F8F0
hi Visual                           guibg=#293739
hi Comment          guifg=#7E8E91
hi Cursor           guifg=#080808   guibg=#F8F8F0
hi CursorLine                       guibg=#293739
hi CursorLineNr     guifg=#FD971F                   gui=none
hi CursorColumn                     guibg=#293739
hi ColorColumn                      guibg=#232526
hi LineNr           guifg=#465457   guibg=#232526
hi NonText          guifg=#465457
hi SpecialKey       guifg=#465457

" Types
hi Boolean          guifg=#AE81FF
hi Number           guifg=#AE81FF
hi Float            guifg=#AE81FF
hi Constant         guifg=#AE81FF                   gui=bold
hi Character        guifg=#E6DB74
hi String           guifg=#E6DB74
hi Define           guifg=#66D9EF
hi Conditional      guifg=#F92672                   gui=bold
hi Debug            guifg=#BCA3A3                   gui=bold
hi Delimiter        guifg=#8F8F8F

" Diff
hi DiffAdd                          guibg=#13354A
hi DiffChange       guifg=#89807D   guibg=#4C4745
hi DiffDelete       guifg=#960050   guibg=#1E0010
hi DiffText                         guibg=#4C4745   gui=italic,bold

hi Directory        guifg=#A6E22E                   gui=bold
hi Error            guifg=#E6DB74   guibg=#1E0010
hi ErrorMsg         guifg=#F92672   guibg=#232526   gui=bold
hi Exception        guifg=#A6E22E                   gui=bold
hi FoldColumn       guifg=#465457   guibg=#000000
hi Folded           guifg=#465457   guibg=#000000
hi Function         guifg=#A6E22E
hi Identifier       guifg=#FD971F
hi Ignore           guifg=#808080   guibg=bg
hi IncSearch        guifg=#C4BE89   guibg=#000000

hi Keyword          guifg=#F92672                   gui=bold
hi Label            guifg=#F92672                   gui=bold
hi Macro            guifg=#A6E22E                   gui=italic
hi SpecialKey       guifg=#66D9EF                   gui=italic

hi MatchParen       guifg=#FD971F   guibg=#000000   gui=bold
hi ModeMsg          guifg=#E6DB74
hi MoreMsg          guifg=#E6DB74
hi Operator         guifg=#F92672

" complete menu
hi Pmenu            guifg=#66D9EF   guibg=#000000
hi PmenuSel                         guibg=#465457
hi PmenuSbar                        guibg=#080808
hi PmenuThumb       guifg=#66D9EF

hi PreCondit        guifg=#A6E22E                   gui=bold
hi PreProc          guifg=#A6E22E
hi Question         guifg=#66D9EF
hi Repeat           guifg=#F92672                   gui=bold
hi Search           guifg=#000000   guibg=#FFE792

" marks
hi SignColumn       guifg=#A6E22E   guibg=#232526
hi SpecialComment   guifg=#7E8E91                   gui=bold
hi Special          guifg=#66D9EF   guibg=bg        gui=italic
hi Statement        guifg=#F92672                   gui=bold
hi StatusLine       guifg=#455354   guibg=fg
hi StatusLineNC     guifg=#808080   guibg=#080808
hi StorageClass     guifg=#FD971F                   gui=italic
hi Structure        guifg=#66D9EF
hi Tag              guifg=#F92672                   gui=italic
hi Title            guifg=#F92672
hi Todo             guifg=#FFFFFF   guibg=bg        gui=bold

hi Typedef          guifg=#66D9EF
hi Type             guifg=#66D9EF                   gui=none
hi Underlined       guifg=#808080                   gui=underline

hi VertSplit        guifg=#465457   guibg=#232526   gui=bold
hi WarningMsg       guifg=#F8F8F0   guibg=#333333   gui=bold
hi WildMenu         guifg=#66D9EF   guibg=#000000

" Tab Line
hi TabLine          guifg=#F8F8F0   guibg=#465457   gui=none
hi TabLineSel       guifg=#080808   guibg=#E6DB74   gui=bold
hi TabLineFill      guifg=#465457

if has('spell')
    hi SpellBad     guisp=#FF0000                   gui=undercurl
    hi SpellCap     guisp=#7070F0                   gui=undercurl
    hi SpellLocal   guisp=#70F0F0                   gui=undercurl
    hi SpellRare    guisp=#FFFFFF                   gui=undercurl
endif
