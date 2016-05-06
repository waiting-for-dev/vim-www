"Open one or more url references
function! www#www#open_references(...)
   for ref in a:000
      call www#www#open_reference(ref)
   endfor
endfunction

"Open one url references
function! www#www#open_reference(ref)
   let url = www#url_helper#get_url_from_ref(a:ref)
   call www#url_handler#handle(url)
endfunction

"Open one or more sessions
function! www#www#open_sessions(...)
   for session_name in a:000
      call www#www#open_session(session_name)
   endfor
endfunction

"Open one session
function! www#www#open_session(session_name)
   let session_dict = www#url_helper#get_session_dictionary()
   if !has_key(session_dict, a:session_name)
      echomsg "[vim-www]: Session ".a:session_name." is not defined in g:www_sessions"
   else
      call call('www#www#open_references', session_dict[a:session_name])
   endif
endfunction

"Search using default search engine
function! www#www#default_search(query)
   if !exists('g:www_default_search_engine')
      echomsg "[vim-www] There is not default search engine configured in g:www_default_search_engine"
   else
      call www#www#open_reference(www#url_helper#get_default_search_engine().a:query)
   endif
endfunction

"Search using search engine provided by user input
function! www#www#search(query)
  let default_search_engine = www#url_helper#get_default_search_engine()
  let cmd = input("Enter search engine to be used: [".default_search_engine."]")
  if empty(cmd)
    call www#www#default_search(a:query)
  else
    call www#www#open_reference(cmd.a:query)
  end
endfunction
