set makeprg=node\ --test\ %
command Format write | silent exec "!prettier --no-semi --single-quote -w % >/dev/null" | execute ':redraw!'

set foldmethod=syntax "syntax highlighting items specify folds
set foldcolumn=1 "defines 1 col at window left, to indicate folding
let g:javaScript_fold=1 "activate folding by JS syntax
set foldlevelstart=99 "start file with all folds opened

