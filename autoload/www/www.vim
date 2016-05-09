"Calls www#www#open_url for each given argument
function! www#www#open_urls(cli, ...)
   for url in a:000
      call www#www#open_url(a:cli, url)
   endfor
endfunction

"Open the url associated with given name in urls dict. If no one, treat name as the actual url.
function! www#www#open_url(cli, name)
  let urls_dict = www#url_helper#get_urls_dictionary()
  if has_key(urls_dict, a:name)
    let url = urls_dict[a:name]
  else
    let url = www#url_helper#parse_url(a:name)
  end
  call www#url_handler#handle(a:cli, url)
endfunction

"Search query in given search engine
function! www#www#search(cli, engine, query)
  let engines_dict = www#url_helper#get_engines_dictionary()
  if has_key(engines_dict, a:engine)
    let dirty_url = engines_dict[a:engine]
    let url = www#url_helper#parse_engine_url(dirty_url, a:query)
    call www#url_handler#handle(a:cli, url)
  else
    echomsg "[vim-www]: Search engine ".a:engine." is not defined in g:www_engines"
  end
endfunction

"Calls www#www#open_session for each given argument
function! www#www#open_sessions(cli, ...)
   for session in a:000
      call www#www#open_session(session, a:cli)
   endfor
endfunction

"Open a session
function! www#www#open_session(session_name, cli)
   let session_dict = www#url_helper#get_session_dictionary()
   if !has_key(session_dict, a:session_name)
      echomsg "[vim-www]: Session ".a:session_name." is not defined in g:www_sessions"
   else
      call call('www#www#open_urls', [a:cli] + session_dict[a:session_name])
   endif
endfunction

"Search using default search engine
function! www#www#default_search(cli, query)
   if exists('g:www_default_search_engine')
      call www#www#search(a:cli, g:www_default_search_engine, a:query)
   else
      call www#www#search(a:cli, g:www#defaults#search_engine, a:query)
   endif
endfunction

"Search using search engine provided by user input
function! www#www#user_input_search(cli, query)
  let default_search_engine = www#url_helper#get_default_search_engine()
  let cmd = input("Enter search engine to be used [".default_search_engine."]: ", "", "custom,www#complete_helper#engines")
  if empty(cmd)
    call www#www#default_search(a:cli, a:query)
  else
    call www#www#search(a:cli, cmd, a:query)
  end
endfunction
