"Calls www#www#open_url for each given argument
function! www#www#open_urls(...)
   for url in a:000
      call www#www#open_url(url)
   endfor
endfunction

"Open the url associated with given name in urls dict. If no one, treat name as the actual url.
function! www#www#open_url(name)
  let urls_dict = www#url_helper#get_urls_dictionary()
  if has_key(urls_dict, a:name)
    let url = urls_dict[a:name]
  else
    let url = www#url_helper#parse_url(a:name)
  end
  call www#url_handler#handle(url)
endfunction

"Search query in given search engine
function! www#www#search(engine, query)
  let engines_dict = www#url_helper#get_engines_dictionary()
  if has_key(engines_dict, a:engine)
    let dirty_url = engines_dict[a:engine]
    let url = www#url_helper#parse_engine_url(dirty_url, a:query)
    call www#url_handler#handle(url)
  else
    echomsg "[vim-www]: Search engine ".a:engine." is not defined in g:www_engines"
  end
endfunction

"Calls www#www#open_session for each given argument
function! www#www#open_sessions(...)
   for session in a:000
      call www#www#open_session(session)
   endfor
endfunction

"Open a session
function! www#www#open_session(session_name)
   let session_dict = www#url_helper#get_session_dictionary()
   if !has_key(session_dict, a:session_name)
      echomsg "[vim-www]: Session ".a:session_name." is not defined in g:www_sessions"
   else
      call call('www#www#open_urls', session_dict[a:session_name])
   endif
endfunction

"Search using default search engine
function! www#www#default_search(query)
   if !exists('g:www_default_search_engine')
      echomsg "[vim-www] There is not default search engine configured in g:www_default_search_engine"
   else
      call www#www#search(g:www_default_search_engine, a:query)
   endif
endfunction

"Search using search engine provided by user input
function! www#www#user_input_search(query)
  let default_search_engine = www#url_helper#get_default_search_engine()
  let cmd = input("Enter search engine to be used [".default_search_engine."]: ", "", "custom,www#complete_helper#engines")
  if empty(cmd)
    call www#www#default_search(a:query)
  else
    call www#www#search(cmd, a:query)
  end
endfunction
