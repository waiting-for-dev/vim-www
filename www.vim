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
   for key in a:000
      if key =~ "\?"
         let position = match(key, "\?")
         let tag = strpart(key, 0, position)
         let query = strpart(key, position + 1)
         let url = substitute(g:www_urls[tag], "{{QUERY}}", query, "g")
      else
         let tag = key
         let url = g:www_urls[tag]
      endif
      :call add(urls, url)
   endfor
   for url in urls
      :call s:handle_url(url)
   endfor
endfunction

function! s:handle_url(url) "{{{
  try 
    if s:is_windows()
      call s:handle_url_in_win(a:url)
      return
    elseif s:is_macunix()
      call s:handle_url_in_macunix(a:url)
      return
    else
      call s:handle_url_in_linux(a:url)
      return
    endif
  endtry
  echomsg 'Default www.vim link handler was unable to open the HTML file!'
endfunction "}}}

function! s:handle_url_in_win(url)
   execute 'silent ! start "Title" /B ' . shellescape(a:url, 1)
endfunction

function! s:handle_url_in_macunix(url)
   execute '!open ' . shellescape(a:url, 1)
endfunction

function! s:handle_url_in_linux(url)
   call system('xdg-open ' . shellescape(a:url, 1).' &')
endfunction

function! s:is_windows() "{{{
  return has("win32") || has("win64") || has("win95") || has("win16")
endfunction "}}}

function! s:is_macunix()
   return has("macunix")
endfunction

"if !exists(":Www")
command! -nargs=+ Www :call s:open_favourites(<f-args>)
"endif
