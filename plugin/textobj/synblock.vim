"=============================================================================
" FILE: plugin/textobj/synblock.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8
if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_textobj_synblock
endif
if exists('g:loaded_textobj_synblock')
  finish
endif
let g:loaded_textobj_synblock = 1
let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('synfun', {
\   '-': {
\     'select-a': 'af', 'select-a-function': 'textobj#synblock#func_select_a_line',
\     'select-i': 'if', 'select-i-function': 'textobj#synblock#func_select_i_line',
\   },
\ })

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
