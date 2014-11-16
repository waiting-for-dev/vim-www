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

if !exists(":Wopen")
   command -complete=custom,www#complete_helper#tags -nargs=+ Wopen :call www#www#open_references(<f-args>)
endif

if !exists(":Wopen1")
   command -complete=custom,www#complete_helper#tags -nargs=1 Wopen1 :call www#www#open_reference(<f-args>)
endif

if !exists(":Wsearch")
   command -nargs=1 Wsearch call www#www#default_search(<f-args>)
endif

if !exists(":Wsession")
   command -complete=custom,www#complete_helper#sessions -nargs=+ Wsession :call www#www#open_sessions(<f-args>)
endif

nnoremap <leader>ws :call www#www#default_search(expand("<cWORD>"))<CR>
vnoremap <leader>ws :call www#www#default_search(@*)<CR>
nnoremap <leader>wb :call www#www#open_reference(expand("<cWORD>"))<CR>
vnoremap <leader>wb :call www#www#open_reference(@*)<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
