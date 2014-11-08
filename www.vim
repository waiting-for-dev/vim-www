" Vim global plugin for opening in a web browser user defined favorite pages
" and search engine results
" Maintainer:	Marc Busqué <marc@lamarciana.com>
" Repository: http://github.com/waiting-for-dev/www.vim

let g:www_urls = {
         \ 'g' : 'http://google.com/#q={{QUERY}}',
         \ 'rails' : 'http://guides.rubyonrails.org/index.html',
         \ 'github' : 'http://github.com',
         \ }

function! s:OpenFavourites(...)
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
      :call s:OpenUrl(url)
   endfor
endfunction

" vimwiki#base#system_open_link
function! s:OpenUrl(url) "{{{
  " handlers
  function! s:win32_handler(url)
    "http://vim.wikia.com/wiki/Opening_current_Vim_file_in_your_Windows_browser
    execute 'silent ! start "Title" /B ' . shellescape(a:url, 1)
  endfunction
  function! s:macunix_handler(url)
    execute '!open ' . shellescape(a:url, 1)
  endfunction
  function! s:linux_handler(url)
    call system('xdg-open ' . shellescape(a:url, 1).' &')
  endfunction
  let success = 0
  try 
    if vimwiki#u#is_windows()
      call s:win32_handler(a:url)
      return
    elseif has("macunix")
      call s:macunix_handler(a:url)
      return
    else
      call s:linux_handler(a:url)
      return
    endif
  endtry
  echomsg 'Default Vimwiki link handler was unable to open the HTML file!'
endfunction "}}}

function! vimwiki#u#is_windows() "{{{
  return has("win32") || has("win64") || has("win95") || has("win16")
endfunction "}}}

"if !exists(":Www")
command! -nargs=+ Www :call s:OpenFavourites(<f-args>)
"endif
