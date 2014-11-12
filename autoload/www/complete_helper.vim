function! www#complete_helper#tags(arg_lead, cmd_line, cursor_pos)
   let options = sort(extend(keys(g:www_urls), ['http://', 'http://www.', 'https://', 'https://www.']))
   return join(options, "\n")
endfunction

function! www#complete_helper#sessions(arg_lead, cmd_line, cursor_pos)
   let options = sort(keys(g:www_sessions))
   return join(sort(options), "\n")
endfunction
