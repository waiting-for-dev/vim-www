" Vim global plugin for opening in a web browser user defined favorite pages
" and search engine results
" Maintainer:	Marc Busqué <marc@lamarciana.com>
" Repository: http://github.com/waiting-for-dev/vim-www

if exists("g:loaded_www")
   finish
endif

let g:loaded_www = "0.0.3"

let s:save_cpo = &cpo
set cpo&vim

"Open given urls
if !exists(":Wopen")
   command -complete=custom,www#complete_helper#urls -nargs=+ Wopen :call www#www#open_urls(<f-args>)
endif

"Search using search engine provided by user input
if !exists(":Wsearch")
   command -nargs=1 Wsearch call www#www#user_input_search(<f-args>)
endif

"Search using default search engine
if !exists(":Wdefaultsearch")
   command -nargs=1 Wdefaultsearch call www#www#default_search(<f-args>)
endif

"Open one or more sessions
if !exists(":Wsession")
   command -complete=custom,www#complete_helper#sessions -nargs=+ Wsession :call www#www#open_sessions(<f-args>)
endif

if !exists('g:www_map_keys')
    let g:www_map_keys = 1
endif

if g:www_map_keys
   "Open WORD under the cursor as url
   nnoremap <leader>wo :call www#www#open_url(expand("<cWORD>"))<CR>
   "Open visual selection as url
   vnoremap <leader>wo :call www#www#open_url(@*)<CR>
   "Search WORD under the cursor
   nnoremap <leader>ws :call www#www#user_input_search(expand("<cWORD>"))<CR>
   "Search visual selection
   vnoremap <leader>ws :call www#www#user_input_search(@*)<CR>
   "Search with default search engine WORD under the cursor
   nnoremap <leader>wd :call www#www#default_search(expand("<cWORD>"))<CR>
   "Search with default search engine visual selection
   vnoremap <leader>wd :call www#www#default_search(@*)<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
