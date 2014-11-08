" Vim global plugin for opening in a web browser user defined favorite pages
" and search engine results
" Maintainer:	Marc Busqué <marc@lamarciana.com>
" Repository: http://github.com/waiting-for-dev/www.vim

let g:www_urls = {
         \ 'g' : 'http://google.com/#q={{QUERY}}',
         \ 'rails' : 'http://guides.rubyonrails.org/index.html',
         \ 'github' : 'http://github.com',
         \ }

function! s:open_favourites(...)
   let urls = []
   for tag_arg in a:000
      :call add(urls, s:get_url_from_tag_arg(tag_arg))
   endfor
   for url in urls
      :call s:UrlHandler.handle(url)
   endfor
endfunction

function! s:get_url_from_tag_arg(tag_arg)
   if a:tag_arg =~ "\?"
      let position = match(a:tag_arg, "\?")
      let tag = strpart(a:tag_arg, 0, position)
      let query = strpart(a:tag_arg, position + 1)
      return substitute(g:www_urls[tag], "{{QUERY}}", query, "g")
   else
      let tag = a:tag_arg
      return g:www_urls[tag]
   endif
endfunction

let s:UrlHandler = {}
function! s:UrlHandler.handle(url) "{{{
  try 
    if s:SystemTools.is_windows()
      call self.handle_in_win(a:url)
      return
    elseif s:SystemTools.is_macunix()
      call self.handle_in_macosx(a:url)
      return
    else
      call self.handle_in_linux(a:url)
      return
    endif
  endtry
  echomsg 'Default www.vim link handler was unable to open the HTML file!'
endfunction "}}}

function! s:UrlHandler.handle_in_win(url)
   execute 'silent ! start "Title" /B ' . shellescape(a:url, 1)
endfunction

function! s:UrlHandler.handle_in_macunix(url)
   execute '!open ' . shellescape(a:url, 1)
endfunction

function! s:UrlHandler.handle_in_linux(url)
   call system('xdg-open ' . shellescape(a:url, 1).' &')
endfunction

let s:SystemTools = {}
function! s:SystemTools.is_windows() "{{{
  return has("win32") || has("win64") || has("win95") || has("win16")
endfunction "}}}

function! s:SystemTools.is_macunix()
   return has("macunix")
endfunction

"if !exists(":Www")
command! -nargs=+ Www :call s:open_favourites(<f-args>)
"endif
