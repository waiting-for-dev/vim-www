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
   command -complete=custom,www#complete_helper#urls -nargs=+ Wopen :call www#www#open_urls(0, <f-args>)
endif

if !exists(":Wcopen")
   command -complete=custom,www#complete_helper#urls -nargs=+ Wcopen :call www#www#open_urls(1, <f-args>)
endif

"Search using search engine provided by user input
if !exists(":Wsearch")
   command -complete=custom,www#complete_helper#engines_from_command -nargs=+ Wsearch call www#www#search_from_command(0, <f-args>)
endif

if !exists(":Wcsearch")
   command -complete=custom,www#complete_helper#engines_from_command -nargs=+ Wcsearch call www#www#search_from_command(1, <f-args>)
endif

"Search using default search engine
if !exists(":Wdefaultsearch")
   command -nargs=1 Wdefaultsearch call www#www#default_search(0, <f-args>)
endif

if !exists(":Wcdefaultsearch")
   command -nargs=1 Wcdefaultsearch call www#www#default_search(1, <f-args>)
endif

"Open one or more sessions
if !exists(":Wsession")
   command -complete=custom,www#complete_helper#sessions -nargs=+ Wsession :call www#www#open_sessions(0, <f-args>)
endif

if !exists(":Wcsession")
   command -complete=custom,www#complete_helper#sessions -nargs=+ Wcsession :call www#www#open_sessions(1, <f-args>)
endif

if !exists('g:www_map_keys')
    let g:www_map_keys = 1
endif

if g:www_map_keys
   "Open WORD under the cursor as url
   nnoremap <leader>wo :call www#www#open_url(0, expand("<cWORD>"))<CR>
   nnoremap <leader>wco :call www#www#open_url(1, expand("<cWORD>"))<CR>
   "Open visual selection as url
   vnoremap <leader>wo :call www#www#open_url(0, @*)<CR>
   vnoremap <leader>wco :call www#www#open_url(1, @*)<CR>
   "Search WORD under the cursor
   nnoremap <leader>ws :call www#www#user_input_search(0, expand("<cWORD>"))<CR>
   nnoremap <leader>wcs :call www#www#user_input_search(1, expand("<cWORD>"))<CR>
   "Search visual selection
   vnoremap <leader>ws :call www#www#user_input_search(0, @*)<CR>
   vnoremap <leader>wcs :call www#www#user_input_search(1, @*)<CR>
   "Search with default search engine WORD under the cursor
   nnoremap <leader>wd :call www#www#default_search(expand(0, "<cWORD>"))<CR>
   nnoremap <leader>wcd :call www#www#default_search(expand(1, "<cWORD>"))<CR>
   "Search with default search engine visual selection
   vnoremap <leader>wd :call www#www#default_search(0, @*)<CR>
   vnoremap <leader>wcd :call www#www#default_search(1, @*)<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
