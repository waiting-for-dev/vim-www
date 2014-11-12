function! www#system_helper#is_windows() "{{{
  return has("win32") || has("win64") || has("win95") || has("win16")
endfunction "}}}

function! www#system_helper#is_macunix()
   return has("macunix")
endfunction
