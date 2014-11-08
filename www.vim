" Vim global plugin for opening in a web browser user defined favorite pages
" and search engine results
" Maintainer:	Marc Busqué <marc@lamarciana.com>
" Repository: http://github.com/waiting-for-dev/www.vim

let g:www_urls = {
         \ 'g' : 'http://google.com',
         \ 'rails' : 'http://guides.rubyonrails.org/index.html',
         \ }

function! s:Open(url)
   call system('xdg-open ' . shellescape(g:www_urls[a:url], 1).' &')
endfunction


"if !exists(":Www")
   command! -nargs=1 Www :call s:Open(<q-args>)
"endif
