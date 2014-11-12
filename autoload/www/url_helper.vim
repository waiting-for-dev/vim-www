function! www#url_helper#get_url_from_tag_arg(tag_arg)
   if a:tag_arg =~ "\?"
      return www#url_helper#get_url_from_tag_with_query(a:tag_arg)
   else
      return www#url_helper#get_url_from_tag(a:tag_arg)
   endif
endfunction

function! www#url_helper#get_url_from_tag(tag_arg)
   let tag_dict = www#url_helper#get_tag_dictionary()
   if has_key(tag_dict, a:tag_arg)
      return tag_dict[a:tag_arg]
   else
      return a:tag_arg
   endif
endfunction

function! www#url_helper#get_url_from_tag_with_query(tag_arg)
   let tag_dict = www#url_helper#get_tag_dictionary()
   let position = match(a:tag_arg, "\?")
   let tag = strpart(a:tag_arg, 0, position + 1)
   if has_key(tag_dict, tag)
      let query = strpart(a:tag_arg, position + 1)
      return substitute(tag_dict[tag], "{{QUERY}}", query, "g")
   else
      :call www#url_helper#inform_tag_no_present(tag)
   end
endfunction

function! www#url_helper#inform_tag_no_present(tag)
   echomsg "[www.vim]: Tag ".a:tag." is not defined in g:www_urls"
endfunction

function! www#url_helper#get_tag_dictionary()
   if exists('g:www_urls')
      return extend(g:www#defaults#tags, g:www_urls)
   else
      return g:www_default_tags
   endif
endfunction

function! www#url_helper#get_session_dictionary()
   if exists('g:www_sessions')
      return extend(g:www#defaults#sessions, g:www_sessions)
   else
      return g:www#defaults#sessions
   endif
endfunction
