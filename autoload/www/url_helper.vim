function! www#url_helper#get_url_from_ref(ref)
   if a:ref =~ "\?"
      return www#url_helper#get_url_for_search_engine(a:ref)
   endif
   let tag_dict = www#url_helper#get_tag_dictionary()
   if has_key(tag_dict, a:ref)
      return tag_dict[a:ref]
   else
      return a:ref
   endif
endfunction

function! www#url_helper#get_url_for_search_engine(ref)
   let tag_dict = www#url_helper#get_tag_dictionary()
   let position = match(a:ref, "\?")
   let tag = strpart(a:ref, 0, position + 1)
   if has_key(tag_dict, tag)
      let query = strpart(a:ref, position + 1)
      return substitute(tag_dict[tag], "{{QUERY}}", query, "g")
   else
      call www#url_helper#inform_tag_no_present(tag)
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

function! www#url_helper#get_default_search_engine()
   if exists('g:www_default_search_engine')
      return g:www_default_search_engine
   else
      return g:www#defaults#search_engine
   endif
endfunction
