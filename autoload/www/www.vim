function! www#www#open_favourites(...)
   for tag_arg in a:000
      :call www#www#open_favourite(tag_arg)
   endfor
endfunction

function! www#www#open_favourite(tag_arg)
   let url = www#url_helper#get_url_from_tag_arg(a:tag_arg)
   :call www#url_handler#handle(url)
endfunction

function! www#www#open_sessions(...)
   for session_name in a:000
      :call www#www#open_session(session_name)
   endfor
endfunction

function! www#www#open_session(session_name)
   if !has_key(g:www_sessions, a:session_name)
      echomsg "[www.vim]: Session ".a:session_name." is not defined in g:www_sessions"
   else
      :call call('www#www#open_favourites', g:www_sessions[a:session_name])
   endif
endfunction

function! www#www#default_search(query)
   if !exists('g:www_default_search_engine')
      echomsg "[www.vim] There is not default search engine configured in g:www_default_search_engine"
   else
      :call www#www#open_favourite(g:www_default_search_engine.a:query)
   endif
endfunction
