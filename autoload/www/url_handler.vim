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
  let command = www#url_handler#extract_command_from_var(g:www_launch_browser_command)
  call www#url_handler#dispatch_to_shell(command, a:url)
endfunction

"Open given url in a cli browser configured by the user
function! www#url_handler#handle_cli(url)
  if !exists('g:www_launch_cli_browser_command')
    call www#www#echo_message('To use cli url handler you must define g:www_launch_cli_browser_command')
  elseif !exists('g:loaded_dispatch')
    call www#www#echo_message('To use cli url handler you must have installed dispatch.vim')
  else
    let command = www#url_handler#extract_command_from_var(g:www_launch_cli_browser_command)
    let command_to_execute = www#url_handler#compose_command(command, a:url)
    execute 'Dispatch '.command_to_execute
  endif
endfunction

"Open given url in a browser in windows
function! www#url_handler#handle_in_win(url)
  call www#url_handler#dispatch_to_shell('start "Title" /B '.a:url)
endfunction

"Open given url in a browser in windows from Cygwin
function! www#url_handler#handle_in_cygwin(url)
  call www#url_handler#dispatch_to_shell('cygstart '.a:url)
endfunction

"Open given url in a browser in macunix
function! www#url_handler#handle_in_macunix(url)
  call www#url_handler#dispatch_to_shell('open '.a:url)
endfunction

"Open given url in a browser in linux
function! www#url_handler#handle_in_linux(url)
  call www#url_handler#dispatch_to_shell('xdg-open '.a:url)
endfunction

"Extract actual command from a variable. Currently, it is expected that the
"command has the actual command as value, but for backwards compatibility
"{{URL}} placeholder is removed.
function www#url_handler#extract_command_from_var(var)
  return substitute(a:var, "{{URL}}", '', 'g')
endfunction

"Dispatch a command with its argument to the shell
function www#url_handler#dispatch_to_shell(command, argument)
  let command_to_execute = www#url_handler#compose_command(a:command, a:argument)
  execute 'silent ! '.command_to_execute
  redraw!
endfunction

"Compose a command to be dispatched to the shell, escaping argument accordingly
function www#url_handler#compose_command(command, argument)
  let escaped_argument = shellescape(a:argument, 1)
  return a:command.' '.escaped_argument
endfunction
