" Vim global plugin for opening in a web browser user defined favorite pages
" and search engine results
" Maintainer:	Marc Busqué <marc@lamarciana.com>
" Repository: http://github.com/waiting-for-dev/www.vim

let g:www_urls = {
         \ 'g' : 'http://google.com',
         \ 'rails' : 'http://guides.rubyonrails.org/index.html',
         \ }

function! s:Open(...)
   let urls = []
   for key in a:000
      :call add(urls, g:www_urls[key])
   endfor
   silent :execute "!iceweasel ".join(urls)." &"
   redraw!
endfunction


"if !exists(":Www")
   command! -nargs=+ Www :call s:Open(<f-args>)
"endif
