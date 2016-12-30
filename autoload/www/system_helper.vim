"Returns whether it is a windows system or not
function! www#system_helper#is_windows()
  return has('win32') || has('win64') || has('win95') || has('win16')
endfunction

"Returns whether it is a Cygwin on windows system or not
function! www#system_helper#is_cygwin()
  return has('win32unix')
endfunction

"Returns whether it is a macunix system or not
function! www#system_helper#is_macunix()
   return has('macunix')
endfunction
