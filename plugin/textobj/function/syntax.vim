"=============================================================================
" FILE: plugin/textobj/function/syntax.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8
if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_textobj_function_syntax
endif
if exists('g:loaded_textobj_function_syntax')
  finish
endif
let g:loaded_textobj_function_syntax = 1
let s:save_cpo = &cpo
set cpo&vim

augroup textobj-function-syntax
  autocmd!
  autocmd BufWinEnter * call <SID>set()
augroup END

function! s:set() abort
  if has_key(b:, 'textobj_function_select')
    return
  endif
  let b:textobj_function_select = function('textobj#function#syntax#select')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
