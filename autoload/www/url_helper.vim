" Parses given url. Right now it, just prepends 'http://' if it does not include
" any protocol
function! www#url_helper#parse_url(url)
  if a:url =~ "://"
    return a:url
  else
    return "http://".a:url
  end
endfunction

" Parses given search engine url for given query
function! www#url_helper#parse_engine_url(url, query)
  if match(a:url, "{{QUERY}}") > -1
    return substitute(a:url, "{{QUERY}}", a:query, "g")
  else
    return a:url.a:query
  endif
endfunction

"Get url's dictionary
function! www#url_helper#get_urls_dictionary()
   if exists('g:www_urls')
      return g:www_urls
   else
      return {}
   endif
endfunction

"Get search engines dictionary; that's a merge between www defaults and user preferences
function! www#url_helper#get_engines_dictionary()
   if exists('g:www_engines')
      return extend(g:www#defaults#engines, g:www_engines)
   else
      return g:www_default_engines
   endif
endfunction

"Get session dictionary; that's a merge between www defaults and user preferences
function! www#url_helper#get_session_dictionary()
   if exists('g:www_sessions')
      return g:www_sessions
   else
      return {}
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
