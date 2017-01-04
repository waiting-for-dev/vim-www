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
  call www#url_handler#dispatch_to_shell(g:www_launch_browser_command, a:url)
endfunction

"Open given url in a cli browser configured by the user
function! www#url_handler#handle_cli(url)
  if !exists('g:www_launch_cli_browser_command')
    call www#www#echo_message('To use cli url handler you must define g:www_launch_cli_browser_command')
  elseif !exists('g:loaded_dispatch')
    call www#www#echo_message('To use cli url handler you must have installed dispatch.vim')
  else
    let command_to_execute = www#url_handler#compose_command(g:www_launch_cli_browser_command, a:url)
    execute 'Dispatch '.command_to_execute
  endif
endfunction

"Open given url in a browser in windows
function! www#url_handler#handle_in_win(url)
  call www#url_handler#dispatch_to_shell('start "Title" /B', a:url)
endfunction

"Open given url in a browser in windows from Cygwin
function! www#url_handler#handle_in_cygwin(url)
  call www#url_handler#dispatch_to_shell('cygstart', a:url)
endfunction

"Open given url in a browser in macunix
function! www#url_handler#handle_in_macunix(url)
  call www#url_handler#dispatch_to_shell('open', a:url)
endfunction

"Open given url in a browser in linux
function! www#url_handler#handle_in_linux(url)
  call www#url_handler#dispatch_to_shell('xdg-open', a:url)
endfunction

"Dispatch a command with its url argument to the shell
function www#url_handler#dispatch_to_shell(command, url)
  let command_to_execute = www#url_handler#compose_command(a:command, a:url)
  execute 'silent ! '.command_to_execute
  redraw!
endfunction

"Compose a command to be dispatched to the shell, escaping url accordingly
function www#url_handler#compose_command(command, url)
  " shellescape() escapes for use as shell command argument. 1 argument escapes
  " special codes, like % which would be interpreted as current file name once
  " dispatched to the shell with bang (!). Later on, bang automatically removes
  " this escaped codes.
  let escaped_url = shellescape(a:url, 1)
  if match(a:command, "{{URL}}") > -1
    " substitute() {sub} code can have special meaning. If we prepend it with
    " \= it is interpreted instead as an expression, which we make a "" string. We
    " then need to escape ". We also need to escape backslash, or it will be
    " interpreted as an escape code and removed
    let replacement_url = '\="'.escape(escaped_url, '\"').'"'
    return substitute(a:command, "{{URL}}", replacement_url, "g")
  else
    return a:command.' '.escaped_url
  endif
endfunction
