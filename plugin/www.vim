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

"Open given urls using cli browser
if !exists(":Wcopen")
   command -complete=custom,www#complete_helper#urls -nargs=+ Wcopen :call www#www#open_urls(1, <f-args>)
endif

"Search using given search engine
if !exists(":Wsearch")
   command -complete=custom,www#complete_helper#engines_first_argument -nargs=+ Wsearch call www#www#search_from_command(0, <f-args>)
endif

"Search using given search engine using cli browser
if !exists(":Wcsearch")
   command -complete=custom,www#complete_helper#engines_first_argument -nargs=+ Wcsearch call www#www#search_from_command(1, <f-args>)
endif

"Open one or more sessions
if !exists(":Wsession")
   command -complete=custom,www#complete_helper#sessions -nargs=+ Wsession :call www#www#open_sessions(0, <f-args>)
endif

"Open one or more sessions using cli browser
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
endif

" Define user configured commands and maps that are a shortcut to search using given engines. Definition have to be made in g:www_magic_engines, which have to be a dictionary { engine: map_keys }. For each entry, dynamic W{engine}/Wc{engine} commands, and w{map_keys}/wc{map_keys} normal & visual mappings are defined that work just as Wsearch/Wcsearch and ws/wcs
if exists('g:www_magic_engines')
  for engine in keys(g:www_magic_engines)
    let map_keys = g:www_magic_engines[engine]
    execute "command -nargs=1 W".engine." call www#www#search(0, '".engine."', <f-args>)"
    execute "command -nargs=1 Wc".engine." call www#www#search(1, '".engine."', <f-args>)"
    execute "nnoremap <leader>w".map_keys." :call www#www#search(0, '".engine."', expand(\"<cWORD>\"))<CR>"
    execute "nnoremap <leader>wc".map_keys." :call www#www#search(1, '".engine."', expand(\"<cWORD>\"))<CR>"
    execute "vnoremap <leader>w".map_keys." :call www#www#search(0, '".engine."', @*)<CR>"
    execute "vnoremap <leader>wc".map_keys." :call www#www#search(1, '".engine."', @*)<CR>"
  endfor
endif

let &cpo = s:save_cpo
unlet s:save_cpo
