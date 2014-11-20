"Given a url reference, return the actual url
function! www#url_helper#get_url_from_ref(ref)
   let tag_dict = www#url_helper#get_tag_dictionary()
   if a:ref =~ "\?"
      return www#url_helper#get_url_for_search_engine(a:ref, tag_dict)
   elseif has_key(tag_dict, a:ref)
      return www#url_helper#get_url_for_plain_tag(a:ref, tag_dict)
   else
      return a:ref
   endif
endfunction

"Given a search engine reference, return the actual url
function! www#url_helper#get_url_for_search_engine(ref, tag_dict)
   let position = match(a:ref, "\?")
   let tag = strpart(a:ref, 0, position + 1)
   if has_key(a:tag_dict, tag)
      let query = strpart(a:ref, position + 1)
      let value = a:tag_dict[tag]
      if match(value, "{{QUERY}}") > -1
         return substitute(value, "{{QUERY}}", query, "g")
      else
         return value.query
      endif
   else
      call www#url_helper#inform_tag_no_present(tag)
   end
endfunction

"Given a plain tag (not a search engine tag), return the actual url
function! www#url_helper#get_url_for_plain_tag(ref, tag_dict)
   return a:tag_dict[a:ref]
endfunction

"Inform a tag is not present
function! www#url_helper#inform_tag_no_present(tag)
   echomsg "[vim-www]: Tag ".a:tag." is not defined in g:www_urls"
endfunction

"Get tag dictionary; that's a merge between www defaults and user preferences
function! www#url_helper#get_tag_dictionary()
   if exists('g:www_urls')
      return extend(g:www#defaults#tags, g:www_urls)
   else
      return g:www_default_tags
   endif
endfunction

"Get session dictionary; that's a merge between www defaults and user preferences
function! www#url_helper#get_session_dictionary()
   if exists('g:www_sessions')
      return extend(g:www#defaults#sessions, g:www_sessions)
   else
      return g:www#defaults#sessions
   endif
endfunction

"Get default search engine; that's www default or user preference
function! www#url_helper#get_default_search_engine()
   if exists('g:www_default_search_engine')
      return g:www_default_search_engine
   else
      return g:www#defaults#search_engine
   endif
endfunction
