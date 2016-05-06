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

" Completion for sessions
function! www#complete_helper#sessions(arg_lead, cmd_line, cursor_pos)
   let session_dict = www#url_helper#get_session_dictionary()
   let sessions = keys(session_dict)
   let options = sort(sessions)
   return join(options, "\n")
endfunction
