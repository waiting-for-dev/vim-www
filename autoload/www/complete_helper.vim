function! www#complete_helper#tags(arg_lead, cmd_line, cursor_pos)
   let tag_dict = www#url_helper#get_tag_dictionary()
   let tags = keys(tag_dict)
   let options = sort(extend(tags, ['http://', 'http://www.', 'https://', 'https://www.']))
   return join(options, "\n")
endfunction

function! www#complete_helper#sessions(arg_lead, cmd_line, cursor_pos)
   let options = sort(keys(g:www_sessions))
   return join(sort(options), "\n")
endfunction
