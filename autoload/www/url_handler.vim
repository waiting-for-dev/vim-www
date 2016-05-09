"Open given url in a browser
function! www#url_handler#handle(cli, url) "{{{
  try 
    if a:cli
      call www#url_handler#handle_cli(a:url)
      return
    elseif exists('g:www_launch_browser_command')
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
  echomsg '[vim-www] An error has occurred trying to launch de browser'
endfunction

"Open given url in a browser using user custom command
function! www#url_handler#handle_custom(url)
   if !exists('g:www_launch_browser_command')
      echomsg '[vim-www] To use a custom url handler you must define g:www_launch_browser_command'
   else
      execute 'silent ! '.substitute(g:www_launch_browser_command, '{{URL}}', shellescape(a:url, 1), 'g')
      redraw!
   endif
endfunction

"Open given url in a cli browser configured by the user
function! www#url_handler#handle_cli(url)
   if !exists('g:www_launch_cli_browser_command')
      echomsg '[vim-www] To use cli url handler you must define g:www_launch_cli_browser_command'
   else
     if exists('g:loaded_dispatch')
       execute 'Dispatch '.substitute(g:www_launch_cli_browser_command, '{{URL}}', shellescape(a:url, 1), 'g')
       redraw!
     else
      echomsg '[vim-www] To use cli url handler you must have installed dispatch.vim'
     end
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
   call system('xdg-open ' . shellescape(a:url).' &')
endfunction
