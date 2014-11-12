function! www#url_helper#get_url_from_tag_arg(tag_arg)
   if a:tag_arg =~ "\?"
      return www#url_helper#get_url_from_tag_with_query(a:tag_arg)
   else
      return www#url_helper#get_url_from_tag(a:tag_arg)
   endif
endfunction

function! www#url_helper#get_url_from_tag(tag_arg)
   if has_key(g:www_urls, a:tag_arg)
      return g:www_urls[a:tag_arg]
   else
      return a:tag_arg
   endif
endfunction

function! www#url_helper#get_url_from_tag_with_query(tag_arg)
   let position = match(a:tag_arg, "\?")
   let tag = strpart(a:tag_arg, 0, position + 1)
   if has_key(g:www_urls, tag)
      let query = strpart(a:tag_arg, position + 1)
      return substitute(g:www_urls[tag], "{{QUERY}}", query, "g")
   else
      :call www#url_helper#inform_tag_no_present(tag)
   end
endfunction

function! www#url_helper#inform_tag_no_present(tag)
   echomsg "[www.vim]: Tag ".a:tag." is not defined in g:www_urls"
endfunction
