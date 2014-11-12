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
   let url = s:UrlHelper.get_url_from_tag_arg(a:tag_arg)
   :call s:UrlHandler.handle(url)
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

let s:UrlHelper = {}
function! s:UrlHelper.get_url_from_tag_arg(tag_arg)
   if a:tag_arg =~ "\?"
      return self.get_url_from_tag_with_query(a:tag_arg)
   else
      return self.get_url_from_tag(a:tag_arg)
   endif
endfunction

function! s:UrlHelper.get_url_from_tag(tag_arg)
   if has_key(g:www_urls, a:tag_arg)
      return g:www_urls[a:tag_arg]
   else
      return a:tag_arg
   endif
endfunction

function! s:UrlHelper.get_url_from_tag_with_query(tag_arg)
   let position = match(a:tag_arg, "\?")
   let tag = strpart(a:tag_arg, 0, position + 1)
   if has_key(g:www_urls, tag)
      let query = strpart(a:tag_arg, position + 1)
      return substitute(g:www_urls[tag], "{{QUERY}}", query, "g")
   else
      :call s:UrlHelper.inform_tag_no_present(tag)
   end
endfunction

function! s:UrlHelper.inform_tag_no_present(tag)
   echomsg "[www.vim]: Tag ".a:tag." is not defined in g:www_urls"
endfunction

let s:UrlHandler = {}
function! s:UrlHandler.handle(url) "{{{
  try 
    if exists('g:www_launch_browser_command')
      call self.handle_custom(a:url)
      return
    elseif s:SystemHelper.is_windows()
      call self.handle_in_win(a:url)
      return
    elseif s:SystemHelper.is_macunix()
      call self.handle_in_macosx(a:url)
      return
    else
      call self.handle_in_linux(a:url)
      return
    endif
  endtry
  echomsg '[www.vim] An error has occurred trying to launch de browser'
endfunction "}}}

function! s:UrlHandler.handle_custom(url)
   if !exists('g:www_launch_browser_command')
      echomsg '[www.vim] To use a custom url handler you must define g:www_launch_browser_command'
   else
      execute 'silent ! '.substitute(g:www_launch_browser_command, '{{URL}}', shellescape(a:url, 1), 'g')
      redraw!
   endif
endfunction

function! s:UrlHandler.handle_in_win(url)
   execute 'silent ! start "Title" /B '.shellescape(a:url, 1)
endfunction

function! s:UrlHandler.handle_in_macunix(url)
   execute '!open ' . shellescape(a:url, 1)
endfunction

function! s:UrlHandler.handle_in_linux(url)
   call system('xdg-open ' . shellescape(a:url, 1).' &')
endfunction

let s:SystemHelper = {}
function! s:SystemHelper.is_windows() "{{{
  return has("win32") || has("win64") || has("win95") || has("win16")
endfunction "}}}

function! s:SystemHelper.is_macunix()
   return has("macunix")
endfunction

function! s:complete_tags(arg_lead, cmd_line, cursor_pos)
   let options = sort(extend(keys(g:www_urls), ['http://', 'http://www.', 'https://', 'https://www.']))
   return join(options, "\n")
endfunction

function! s:complete_sessions(arg_lead, cmd_line, cursor_pos)
   let options = sort(keys(g:www_sessions))
   return join(sort(options), "\n")
endfunction

"if !exists(":Www")
command! -complete=custom,s:complete_tags -nargs=+ Wopen :call s:open_favourites(<f-args>)
command! -complete=custom,s:complete_tags -nargs=1 Wopen1 :call s:open_favourite(<f-args>)
command! -nargs=1 Wsearch :call s:default_search(<f-args>)
command! -complete=custom,s:complete_sessions -nargs=+ Wsession :call s:open_sessions(<f-args>)
"endif

let &cpo = s:save_cpo
unlet s:save_cpo
