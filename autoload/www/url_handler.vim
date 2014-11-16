"Open given url in a browser
function! www#url_handler#handle(url) "{{{
  try 
    if exists('g:www_launch_browser_command')
      call www#url_handler#handle_custom(a:url)
      return
    elseif www#system_helper#is_windows()
      call www#url_handler#handle_in_win(a:url)
      return
    elseif www#system_helper#is_macunix()
      call www#url_handler#handle_in_macosx(a:url)
      return
    else
      call www#url_handler#handle_in_linux(a:url)
      return
    endif
  endtry
  echomsg '[www.vim] An error has occurred trying to launch de browser'
endfunction "}}}

"Open given url in a browser using user custom command
function! www#url_handler#handle_custom(url)
   if !exists('g:www_launch_browser_command')
      echomsg '[www.vim] To use a custom url handler you must define g:www_launch_browser_command'
   else
      execute 'silent ! '.substitute(g:www_launch_browser_command, '{{URL}}', shellescape(a:url, 1), 'g')
      redraw!
   endif
endfunction

"Open given url in a browser in windows
function! www#url_handler#handle_in_win(url)
   execute 'silent ! start "Title" /B '.shellescape(a:url, 1)
endfunction

"Open given url in a browser in macunix
function! www#url_handler#handle_in_macunix(url)
   execute '!open ' . shellescape(a:url, 1)
endfunction

"Open given url in a browser in linux
function! www#url_handler#handle_in_linux(url)
   call system('xdg-open ' . shellescape(a:url, 1).' &')
endfunction
