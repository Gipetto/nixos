" Birren Industrial — Vim colorscheme (dark + light)
" Requires: set termguicolors
"
" Usage:
"   Copy to ~/.vim/colors/ (or ~/.config/nvim/colors/ for Neovim)
"   Then:  colorscheme birren-industrial

highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'birren-industrial'

" ---------- Dark ----------
if &background ==# 'dark'

  highlight Normal        guifg=#e8e0d5 guibg=#2a2a28
  highlight NormalFloat   guifg=#e8e0d5 guibg=#3a3a38
  highlight NormalNC      guifg=#e8e0d5 guibg=#2a2a28

  " --- Chrome ---
  highlight LineNr        guifg=#6b6b68 guibg=NONE
  highlight CursorLineNr  guifg=#7fb5a0 guibg=NONE    gui=bold
  highlight CursorLine    guibg=#3a3a38                gui=NONE
  highlight CursorColumn  guibg=#3a3a38
  highlight ColorColumn   guibg=#3a3a38
  highlight SignColumn    guifg=#6b6b68 guibg=NONE
  highlight FoldColumn    guifg=#6b6b68 guibg=NONE
  highlight Folded        guifg=#5b7a8e guibg=#3a3a38  gui=italic
  highlight VertSplit     guifg=#6b6b68 guibg=NONE
  highlight WinSeparator  guifg=#6b6b68 guibg=NONE
  highlight StatusLine    guifg=#e8e0d5 guibg=#3a3a38  gui=NONE
  highlight StatusLineNC  guifg=#6b6b68 guibg=#3a3a38  gui=NONE
  highlight TabLine       guifg=#a69f95 guibg=#3a3a38  gui=NONE
  highlight TabLineFill   guibg=#3a3a38                gui=NONE
  highlight TabLineSel    guifg=#7fb5a0 guibg=#2a2a28  gui=bold
  highlight WildMenu      guifg=#2a2a28 guibg=#7fb5a0

  " --- Search / Visual ---
  highlight Visual        guibg=#5a8a7350
  highlight VisualNOS     guibg=#5a8a7350
  highlight Search        guifg=#2a2a28 guibg=#f2b632
  highlight IncSearch     guifg=#2a2a28 guibg=#d67d3e  gui=NONE
  highlight CurSearch     guifg=#2a2a28 guibg=#f2b632  gui=bold
  highlight MatchParen    guifg=#7fb5a0 guibg=#7fb5a040 gui=bold

  " --- Popup menu ---
  highlight Pmenu         guifg=#e8e0d5 guibg=#3a3a38
  highlight PmenuSel      guifg=#e8e0d5 guibg=#5a8a73
  highlight PmenuSbar     guibg=#3a3a38
  highlight PmenuThumb    guibg=#6b6b68

  " --- Diff ---
  highlight DiffAdd       guifg=NONE    guibg=#7fb5a020
  highlight DiffChange    guifg=NONE    guibg=#5b7a8e20
  highlight DiffDelete    guifg=#c83e3a guibg=#c83e3a20
  highlight DiffText      guifg=NONE    guibg=#d67d3e30 gui=NONE

  " --- Messages ---
  highlight ErrorMsg      guifg=#c83e3a guibg=NONE     gui=bold
  highlight WarningMsg    guifg=#d67d3e guibg=NONE
  highlight MoreMsg       guifg=#7fb5a0 guibg=NONE
  highlight Question      guifg=#7fb5a0 guibg=NONE
  highlight ModeMsg       guifg=#7fb5a0 guibg=NONE     gui=bold
  highlight Title         guifg=#7fb5a0 guibg=NONE     gui=bold
  highlight Directory     guifg=#7fb5a0 guibg=NONE

  " --- Spelling ---
  highlight SpellBad      guisp=#c83e3a gui=undercurl
  highlight SpellCap      guisp=#5b7a8e gui=undercurl
  highlight SpellRare     guisp=#8b5a3c gui=undercurl
  highlight SpellLocal    guisp=#7fb5a0 gui=undercurl

  " --- Misc ---
  highlight NonText       guifg=#6b6b68 guibg=NONE
  highlight SpecialKey    guifg=#6b6b68 guibg=NONE
  highlight Conceal       guifg=#6b6b68 guibg=NONE
  highlight Cursor        guifg=#2a2a28 guibg=#7fb5a0
  highlight lCursor       guifg=#2a2a28 guibg=#7fb5a0

  " --- Syntax ---
  highlight Comment       guifg=#5b7a8e gui=italic
  highlight String        guifg=#7fb5a0
  highlight Character     guifg=#5a8a73
  highlight Number        guifg=#c83e3a
  highlight Float         guifg=#c83e3a
  highlight Boolean       guifg=#c83e3a
  highlight Constant      guifg=#c83e3a

  highlight Identifier    guifg=#e8e0d5 gui=NONE
  highlight Function      guifg=#f2b632

  highlight Statement     guifg=#d67d3e gui=NONE
  highlight Conditional   guifg=#d67d3e gui=NONE
  highlight Repeat        guifg=#d67d3e gui=NONE
  highlight Label         guifg=#d67d3e gui=NONE
  highlight Operator      guifg=#a69f95
  highlight Keyword       guifg=#d67d3e gui=NONE
  highlight Exception     guifg=#d67d3e gui=NONE

  highlight PreProc       guifg=#d67d3e
  highlight Include       guifg=#d67d3e
  highlight Define        guifg=#d67d3e
  highlight Macro         guifg=#d67d3e
  highlight PreCondit     guifg=#d67d3e

  highlight Type          guifg=#5b7a8e gui=NONE
  highlight StorageClass  guifg=#d67d3e gui=NONE
  highlight Structure     guifg=#5b7a8e gui=NONE
  highlight Typedef       guifg=#5b7a8e gui=NONE

  highlight Special       guifg=#5a8a73
  highlight SpecialChar   guifg=#5a8a73
  highlight Tag           guifg=#d67d3e
  highlight Delimiter     guifg=#a69f95
  highlight Debug         guifg=#d67d3e

  highlight Error         guifg=#c83e3a guibg=NONE     gui=bold
  highlight Todo          guifg=#f2b632 guibg=NONE     gui=bold,italic

  " --- Treesitter / LSP (Neovim 0.8+) ---
  highlight @comment           guifg=#5b7a8e gui=italic
  highlight @string            guifg=#7fb5a0
  highlight @string.escape     guifg=#5a8a73
  highlight @string.regex      guifg=#5a8a73
  highlight @character         guifg=#5a8a73
  highlight @number            guifg=#c83e3a
  highlight @boolean           guifg=#c83e3a
  highlight @float             guifg=#c83e3a
  highlight @constant          guifg=#c83e3a
  highlight @constant.builtin  guifg=#c83e3a
  highlight @variable          guifg=#e8e0d5
  highlight @variable.builtin  guifg=#e8e0d5
  highlight @property          guifg=#a69f95
  highlight @field             guifg=#a69f95
  highlight @parameter         guifg=#e8e0d5
  highlight @function          guifg=#f2b632
  highlight @function.builtin  guifg=#f2b632
  highlight @function.call     guifg=#f2b632
  highlight @method            guifg=#f2b632
  highlight @method.call       guifg=#f2b632
  highlight @constructor       guifg=#5b7a8e
  highlight @keyword           guifg=#d67d3e
  highlight @keyword.function  guifg=#d67d3e
  highlight @keyword.return    guifg=#d67d3e
  highlight @keyword.operator  guifg=#a69f95
  highlight @conditional       guifg=#d67d3e
  highlight @repeat            guifg=#d67d3e
  highlight @exception         guifg=#d67d3e
  highlight @include           guifg=#d67d3e
  highlight @type              guifg=#5b7a8e
  highlight @type.builtin      guifg=#5b7a8e
  highlight @type.qualifier    guifg=#d67d3e
  highlight @storageclass      guifg=#d67d3e
  highlight @attribute         guifg=#8b5a3c
  highlight @tag               guifg=#d67d3e
  highlight @tag.attribute     guifg=#8b5a3c
  highlight @tag.delimiter     guifg=#a69f95
  highlight @punctuation       guifg=#a69f95
  highlight @punctuation.bracket    guifg=#a69f95
  highlight @punctuation.delimiter  guifg=#a69f95
  highlight @punctuation.special    guifg=#a69f95
  highlight @operator          guifg=#a69f95
  highlight @text.title        guifg=#7fb5a0 gui=bold
  highlight @text.literal      guifg=#7fb5a0
  highlight @text.uri          guifg=#5b7a8e gui=underline
  highlight @text.strong       guifg=#d67d3e gui=bold
  highlight @text.emphasis     gui=italic

  " --- Diagnostics (Neovim) ---
  highlight DiagnosticError          guifg=#c83e3a
  highlight DiagnosticWarn           guifg=#d67d3e
  highlight DiagnosticInfo           guifg=#5b7a8e
  highlight DiagnosticHint           guifg=#7fb5a0
  highlight DiagnosticUnderlineError guisp=#c83e3a gui=undercurl
  highlight DiagnosticUnderlineWarn  guisp=#d67d3e gui=undercurl
  highlight DiagnosticUnderlineInfo  guisp=#5b7a8e gui=undercurl
  highlight DiagnosticUnderlineHint  guisp=#7fb5a0 gui=undercurl

  " --- Terminal colors ---
  if has('nvim')
    let g:terminal_color_0  = '#2a2a28'
    let g:terminal_color_1  = '#c83e3a'
    let g:terminal_color_2  = '#7fb5a0'
    let g:terminal_color_3  = '#f2b632'
    let g:terminal_color_4  = '#5b7a8e'
    let g:terminal_color_5  = '#8b5a3c'
    let g:terminal_color_6  = '#7fb5a0'
    let g:terminal_color_7  = '#e8e0d5'
    let g:terminal_color_8  = '#6b6b68'
    let g:terminal_color_9  = '#d67d3e'
    let g:terminal_color_10 = '#5a8a73'
    let g:terminal_color_11 = '#c9b89a'
    let g:terminal_color_12 = '#7fb5a0'
    let g:terminal_color_13 = '#a69f95'
    let g:terminal_color_14 = '#7fb5a0'
    let g:terminal_color_15 = '#e8e0d5'
  elseif has('terminal')
    let g:terminal_ansi_colors = [
      \ '#2a2a28', '#c83e3a', '#7fb5a0', '#f2b632',
      \ '#5b7a8e', '#8b5a3c', '#7fb5a0', '#e8e0d5',
      \ '#6b6b68', '#d67d3e', '#5a8a73', '#c9b89a',
      \ '#7fb5a0', '#a69f95', '#7fb5a0', '#e8e0d5',
      \ ]
  endif

" ---------- Light ----------
else

  highlight Normal        guifg=#2a2a28 guibg=#e8e0d5
  highlight NormalFloat   guifg=#2a2a28 guibg=#d8d0c5
  highlight NormalNC      guifg=#2a2a28 guibg=#e8e0d5

  " --- Chrome ---
  highlight LineNr        guifg=#a69f95 guibg=NONE
  highlight CursorLineNr  guifg=#5a8a73 guibg=NONE    gui=bold
  highlight CursorLine    guibg=#d8d0c5                gui=NONE
  highlight CursorColumn  guibg=#d8d0c5
  highlight ColorColumn   guibg=#d8d0c5
  highlight SignColumn    guifg=#a69f95 guibg=NONE
  highlight FoldColumn    guifg=#a69f95 guibg=NONE
  highlight Folded        guifg=#6b6b68 guibg=#d8d0c5  gui=italic
  highlight VertSplit     guifg=#a69f95 guibg=NONE
  highlight WinSeparator  guifg=#a69f95 guibg=NONE
  highlight StatusLine    guifg=#2a2a28 guibg=#d8d0c5  gui=NONE
  highlight StatusLineNC  guifg=#a69f95 guibg=#d8d0c5  gui=NONE
  highlight TabLine       guifg=#6b6b68 guibg=#d8d0c5  gui=NONE
  highlight TabLineFill   guibg=#d8d0c5                gui=NONE
  highlight TabLineSel    guifg=#5a8a73 guibg=#e8e0d5  gui=bold
  highlight WildMenu      guifg=#e8e0d5 guibg=#5a8a73

  " --- Search / Visual ---
  highlight Visual        guibg=#5a8a7350
  highlight VisualNOS     guibg=#5a8a7350
  highlight Search        guifg=#2a2a28 guibg=#f2b632
  highlight IncSearch     guifg=#2a2a28 guibg=#d67d3e  gui=NONE
  highlight CurSearch     guifg=#2a2a28 guibg=#f2b632  gui=bold
  highlight MatchParen    guifg=#5a8a73 guibg=#5a8a7340 gui=bold

  " --- Popup menu ---
  highlight Pmenu         guifg=#2a2a28 guibg=#d8d0c5
  highlight PmenuSel      guifg=#e8e0d5 guibg=#5a8a73
  highlight PmenuSbar     guibg=#d8d0c5
  highlight PmenuThumb    guibg=#a69f95

  " --- Diff ---
  highlight DiffAdd       guifg=NONE    guibg=#5a8a7320
  highlight DiffChange    guifg=NONE    guibg=#5b7a8e20
  highlight DiffDelete    guifg=#c83e3a guibg=#c83e3a20
  highlight DiffText      guifg=NONE    guibg=#d67d3e30 gui=NONE

  " --- Messages ---
  highlight ErrorMsg      guifg=#c83e3a guibg=NONE     gui=bold
  highlight WarningMsg    guifg=#d67d3e guibg=NONE
  highlight MoreMsg       guifg=#5a8a73 guibg=NONE
  highlight Question      guifg=#5a8a73 guibg=NONE
  highlight ModeMsg       guifg=#5a8a73 guibg=NONE     gui=bold
  highlight Title         guifg=#5a8a73 guibg=NONE     gui=bold
  highlight Directory     guifg=#5a8a73 guibg=NONE

  " --- Spelling ---
  highlight SpellBad      guisp=#c83e3a gui=undercurl
  highlight SpellCap      guisp=#5b7a8e gui=undercurl
  highlight SpellRare     guisp=#8b5a3c gui=undercurl
  highlight SpellLocal    guisp=#5a8a73 gui=undercurl

  " --- Misc ---
  highlight NonText       guifg=#a69f95 guibg=NONE
  highlight SpecialKey    guifg=#a69f95 guibg=NONE
  highlight Conceal       guifg=#a69f95 guibg=NONE
  highlight Cursor        guifg=#e8e0d5 guibg=#5a8a73
  highlight lCursor       guifg=#e8e0d5 guibg=#5a8a73

  " --- Syntax ---
  highlight Comment       guifg=#6b6b68 gui=italic
  highlight String        guifg=#5a8a73
  highlight Character     guifg=#7fb5a0
  highlight Number        guifg=#c83e3a
  highlight Float         guifg=#c83e3a
  highlight Boolean       guifg=#c83e3a
  highlight Constant      guifg=#c83e3a

  highlight Identifier    guifg=#2a2a28 gui=NONE
  highlight Function      guifg=#d67d3e

  highlight Statement     guifg=#8b5a3c gui=NONE
  highlight Conditional   guifg=#8b5a3c gui=NONE
  highlight Repeat        guifg=#8b5a3c gui=NONE
  highlight Label         guifg=#8b5a3c gui=NONE
  highlight Operator      guifg=#6b6b68
  highlight Keyword       guifg=#8b5a3c gui=NONE
  highlight Exception     guifg=#8b5a3c gui=NONE

  highlight PreProc       guifg=#8b5a3c
  highlight Include       guifg=#8b5a3c
  highlight Define        guifg=#8b5a3c
  highlight Macro         guifg=#8b5a3c
  highlight PreCondit     guifg=#8b5a3c

  highlight Type          guifg=#5b7a8e gui=NONE
  highlight StorageClass  guifg=#8b5a3c gui=NONE
  highlight Structure     guifg=#5b7a8e gui=NONE
  highlight Typedef       guifg=#5b7a8e gui=NONE

  highlight Special       guifg=#7fb5a0
  highlight SpecialChar   guifg=#7fb5a0
  highlight Tag           guifg=#8b5a3c
  highlight Delimiter     guifg=#6b6b68
  highlight Debug         guifg=#8b5a3c

  highlight Error         guifg=#c83e3a guibg=NONE     gui=bold
  highlight Todo          guifg=#d67d3e guibg=NONE     gui=bold,italic

  " --- Treesitter / LSP (Neovim 0.8+) ---
  highlight @comment           guifg=#6b6b68 gui=italic
  highlight @string            guifg=#5a8a73
  highlight @string.escape     guifg=#7fb5a0
  highlight @string.regex      guifg=#7fb5a0
  highlight @character         guifg=#7fb5a0
  highlight @number            guifg=#c83e3a
  highlight @boolean           guifg=#c83e3a
  highlight @float             guifg=#c83e3a
  highlight @constant          guifg=#c83e3a
  highlight @constant.builtin  guifg=#c83e3a
  highlight @variable          guifg=#2a2a28
  highlight @variable.builtin  guifg=#2a2a28
  highlight @property          guifg=#6b6b68
  highlight @field             guifg=#6b6b68
  highlight @parameter         guifg=#2a2a28
  highlight @function          guifg=#d67d3e
  highlight @function.builtin  guifg=#d67d3e
  highlight @function.call     guifg=#d67d3e
  highlight @method            guifg=#d67d3e
  highlight @method.call       guifg=#d67d3e
  highlight @constructor       guifg=#5b7a8e
  highlight @keyword           guifg=#8b5a3c
  highlight @keyword.function  guifg=#8b5a3c
  highlight @keyword.return    guifg=#8b5a3c
  highlight @keyword.operator  guifg=#6b6b68
  highlight @conditional       guifg=#8b5a3c
  highlight @repeat            guifg=#8b5a3c
  highlight @exception         guifg=#8b5a3c
  highlight @include           guifg=#8b5a3c
  highlight @type              guifg=#5b7a8e
  highlight @type.builtin      guifg=#5b7a8e
  highlight @type.qualifier    guifg=#8b5a3c
  highlight @storageclass      guifg=#8b5a3c
  highlight @attribute         guifg=#8b5a3c
  highlight @tag               guifg=#8b5a3c
  highlight @tag.attribute     guifg=#8b5a3c
  highlight @tag.delimiter     guifg=#6b6b68
  highlight @punctuation       guifg=#6b6b68
  highlight @punctuation.bracket    guifg=#6b6b68
  highlight @punctuation.delimiter  guifg=#6b6b68
  highlight @punctuation.special    guifg=#6b6b68
  highlight @operator          guifg=#6b6b68
  highlight @text.title        guifg=#5a8a73 gui=bold
  highlight @text.literal      guifg=#5a8a73
  highlight @text.uri          guifg=#5b7a8e gui=underline
  highlight @text.strong       guifg=#8b5a3c gui=bold
  highlight @text.emphasis     gui=italic

  " --- Diagnostics (Neovim) ---
  highlight DiagnosticError          guifg=#c83e3a
  highlight DiagnosticWarn           guifg=#d67d3e
  highlight DiagnosticInfo           guifg=#5b7a8e
  highlight DiagnosticHint           guifg=#5a8a73
  highlight DiagnosticUnderlineError guisp=#c83e3a gui=undercurl
  highlight DiagnosticUnderlineWarn  guisp=#d67d3e gui=undercurl
  highlight DiagnosticUnderlineInfo  guisp=#5b7a8e gui=undercurl
  highlight DiagnosticUnderlineHint  guisp=#5a8a73 gui=undercurl

  " --- Terminal colors ---
  if has('nvim')
    let g:terminal_color_0  = '#2a2a28'
    let g:terminal_color_1  = '#c83e3a'
    let g:terminal_color_2  = '#5a8a73'
    let g:terminal_color_3  = '#d67d3e'
    let g:terminal_color_4  = '#5b7a8e'
    let g:terminal_color_5  = '#8b5a3c'
    let g:terminal_color_6  = '#5a8a73'
    let g:terminal_color_7  = '#6b6b68'
    let g:terminal_color_8  = '#a69f95'
    let g:terminal_color_9  = '#c83e3a'
    let g:terminal_color_10 = '#7fb5a0'
    let g:terminal_color_11 = '#f2b632'
    let g:terminal_color_12 = '#7fb5a0'
    let g:terminal_color_13 = '#8b5a3c'
    let g:terminal_color_14 = '#7fb5a0'
    let g:terminal_color_15 = '#2a2a28'
  elseif has('terminal')
    let g:terminal_ansi_colors = [
      \ '#2a2a28', '#c83e3a', '#5a8a73', '#d67d3e',
      \ '#5b7a8e', '#8b5a3c', '#5a8a73', '#6b6b68',
      \ '#a69f95', '#c83e3a', '#7fb5a0', '#f2b632',
      \ '#7fb5a0', '#8b5a3c', '#7fb5a0', '#2a2a28',
      \ ]
  endif

endif
