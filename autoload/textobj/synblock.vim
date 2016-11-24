"=============================================================================
" FILE: autoload/textobj/synblock.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:Synblock = vital#synblock#import('Vim.Synblock')

function! textobj#synblock#func_select_i_line(synname_body) abort
  let block = s:Synblock.synblock(line('.'), col('.'), a:synname_body)
  if empty(block)
    return 0
  endif
  let start = [0] + block.start + [0]
  let start[1] += 1
  let end = [0] + block.end + [0]
  if getline(block.end[0])[:block.end[1]-1] =~# '^\s\+$'
    let end[1] -= 1
  endif
  return ['V', start, end]
endfunction

function! textobj#synblock#func_select_a_line(synname_body) abort
  let block = s:Synblock.synblock(line('.'), col('.'), a:synname_body)
  if empty(block)
    return 0
  endif
  let start = [0] + block.start + [0]
  let end = [0] + block.end + [0]
  if getline(block.end[0])[:block.end[1]-1] !~# '^\s\+$'
    let end[1] += 1
  endif
  return ['V', start, end]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
