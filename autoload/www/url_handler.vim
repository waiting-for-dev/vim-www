"Open given url in a browser. If cli is 1 it will be in the configured cli
"browser. If 0 it will be in the configured browser or, if not set, it will
"try to guess the command to use
function! www#url_handler#handle(cli, url)
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
    elseif www#system_helper#is_cygwin()
      call www#url_handler#handle_in_cygwin(a:url)
      return
    elseif www#system_helper#is_macunix()
      call www#url_handler#handle_in_macunix(a:url)
      return
    else
      call www#url_handler#handle_in_linux(a:url)
      return
    endif
  endtry
  call www#www#echo_message('An error has occurred trying to launch the browser')
endfunction

"Open given url in a browser using user custom command
function! www#url_handler#handle_custom(url)
  execute 'silent ! '.substitute(g:www_launch_browser_command, "{{URL}}", escape(shellescape(a:url, 1), '#'), 'g')
  redraw!
endfunction

"Open given url in a cli browser configured by the user
function! www#url_handler#handle_cli(url)
  if !exists('g:www_launch_cli_browser_command')
    call www#www#echo_message('To use cli url handler you must define g:www_launch_cli_browser_command')
  elseif !exists('g:loaded_dispatch')
    call www#www#echo_message('To use cli url handler you must have installed dispatch.vim')
  else
    execute 'Dispatch '.substitute(g:www_launch_cli_browser_command, '{{URL}}', escape(shellescape(a:url, 1), '#'), 'g')
    redraw!
  endif
endfunction

"Open given url in a browser in windows
function! www#url_handler#handle_in_win(url)
   execute 'silent ! start "Title" /B '.shellescape(a:url, 1)
endfunction

"Open given url in a browser in windows from Cygwin
function! www#url_handler#handle_in_cygwin(url)
   execute 'silent ! cygstart '.shellescape(a:url, 1)
   redraw!
endfunction

"Open given url in a browser in macunix
function! www#url_handler#handle_in_macunix(url)
   execute '!open ' . shellescape(a:url, 1)
endfunction

"Open given url in a browser in linux
function! www#url_handler#handle_in_linux(url)
   call system('xdg-open ' . shellescape(a:url).' &')
endfunction
