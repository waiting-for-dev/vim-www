" Completion for url's
function! www#complete_helper#urls(arg_lead, cmd_line, cursor_pos)
   let url_dict = www#url_helper#get_urls_dictionary()
   let names = keys(url_dict)
   let options = sort(extend(names, ['http://', 'http://www.', 'https://', 'https://www.']))
   return join(options, "\n")
endfunction

" Completion for search engines
function! www#complete_helper#engines(arg_lead, cmd_line, cursor_pos)
   let engines_dict = www#url_helper#get_engines_dictionary()
   let names = keys(engines_dict)
   let options = sort(names)
   return join(options, "\n")
endfunction

" Completion for search engines only for the first argument in a command
function! www#complete_helper#engines_first_argument(arg_lead, cmd_line, cursor_pos)
  let cmd_line_parts = split(a:cmd_line, '\s\+')
  if len(cmd_line_parts) == 1 || (len(cmd_line_parts) == 2 && a:arg_lead != '')
    return www#complete_helper#engines(a:arg_lead, a:cmd_line, a:cursor_pos)
  else
    return ''
  endif
endfunction

" Completion for sessions
function! www#complete_helper#sessions(arg_lead, cmd_line, cursor_pos)
   let session_dict = www#url_helper#get_session_dictionary()
   let sessions = keys(session_dict)
   let options = sort(sessions)
   return join(options, "\n")
endfunction
