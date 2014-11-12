" Vim global plugin for opening in a web browser user defined favorite pages
" and search engine results
" Maintainer:	Marc Busqué <marc@lamarciana.com>
" Repository: http://github.com/waiting-for-dev/www.vim

if exists("g:loaded_www")
   finish
endif

let g:loaded_www = "0.0.1"

let s:save_cpo = &cpo
set cpo&vim

let g:www_urls = {
         \ 'g?' : 'https://www.google.com/search?q={{QUERY}}',
         \ 'rails' : 'http://guides.rubyonrails.org/index.html',
         \ 'ruby': 'https://www.ruby-lang.org',
         \ 'github' : 'http://github.com',
         \ }
let g:www_default_search_engine = 'g?'
let g:www_sessions = {
         \ 'ruby' : ['rails', 'ruby'],
         \ 'github' : ['github'],
         \ }
"let g:www_launch_browser_command = 'google-chrome {{URL}} &'

function! s:open_favourites(...)
   for tag_arg in a:000
      :call s:open_favourite(tag_arg)
   endfor
endfunction

function! s:open_favourite(tag_arg)
   let url = www#url_helper#get_url_from_tag_arg(a:tag_arg)
   :call www#url_handler#handle(url)
endfunction

function! s:open_sessions(...)
   for session_name in a:000
      :call s:open_session(session_name)
   endfor
endfunction

function! s:open_session(session_name)
   if !has_key(g:www_sessions, a:session_name)
      echomsg "[www.vim]: Session ".a:session_name." is not defined in g:www_sessions"
   else
      :call call('s:open_favourites', g:www_sessions[a:session_name])
   endif
endfunction

function! s:default_search(query)
   if !exists('g:www_default_search_engine')
      echomsg "[www.vim] There is not default search engine configured in g:www_default_search_engine"
   else
      :call s:open_favourite(g:www_default_search_engine.a:query)
   endif
endfunction

if !exists(":Wopen")
   command -complete=custom,www#complete_helper#tags -nargs=+ Wopen :call s:open_favourites(<f-args>)
endif

if !exists(":Wopen1")
   command -complete=custom,www#complete_helper#tags -nargs=1 Wopen1 :call s:open_favourite(<f-args>)
endif

if !exists(":Wsearch")
   command -nargs=1 Wsearch :call s:default_search(<f-args>)
endif

if !exists(":Wsession")
   command -complete=custom,www#complete_helper#sessions -nargs=+ Wsession :call s:open_sessions(<f-args>)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
