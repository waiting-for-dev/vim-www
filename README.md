# vim-www

Toolbox to open & search URLs from vim

## Installation

Just like any other vim plugin. Use [pathogen](https://github.com/tpope/vim-pathogen), [neobundle](https://github.com/Shougo/neobundle.vim) or [vundle](https://github.com/gmarik/Vundle.vim), or just [unzip](https://github.com/waiting-for-dev/vim-www/archive/master.zip) it inside your `$HOME/.vim` directory.

## Usage

vim-www allows launching a web browser from vim to open arbitrary URLs, defined favorites and search engine results.

The web browser to be used is detected automatically, but it can be manually set through `g:www_launch_browser_command`, using `{{URL}}}` as placeholder for the actual URL. E.g.:

    let g:www_launch_browser_command = "iceweasel {{URL}} &"

In the same way, an alternative CLI browser can be set through `g:www_launch_cli_browser_command`. In order to work, [vim-dispatch](https://github.com/tpope/vim-dispatch) add-on must be installed. Its purpose is to open a web, for example, in a [tmux](https://tmux.github.io/) pane, or in a virtual terminal if [neovim](https://github.com/neovim/neovim) and [vim-dispatch-neovim](https://github.com/radenling/vim-dispatch-neovim) are being used.

### Favorites and arbitrary URLs

`:Wopen` opens any given URL. E.g.:

    :Wopen http://vim.org

But typing and remembering full URLs is annoying, so custom favorites can be defined in `g:www_urls` dictionary.

So, having in `vimrc`,

    let g:www_urls = {
      \ 'vim' : 'http://www.vim.org',
      \ }

following command does the same than previous one:

    :Wopen vim

Also, in normal mode, `<leader>wo` launches the browser using `WORD` under cursor as URL. In visual mode it does the same but taking current text selection as URL.

`:Wcopen` command and `<leader>wco` mappings do the same but using the CLI browser.

### Search engines

`:Wsearch` queries a search engine and opens the corresponding results page:

E.g.:

    :Wsearch google how to learn vim

Previous command opens the resulting page of searching `how to learn vim` in google.

Following search engines are provided by default: bitbucket, duckduckgo, google, github, stackoverflow and wikipedia.

More search engines can be added through `g:www_engines` dictionary. Query is appended at the end of given URL.  E.g.:

    let g:www_engines = {
      \ 'youtube' : 'https://www.youtube.com/results?search_query=',
      \ }

In normal mode, `<leader>ws` searches `WORD` under cursor, while the same mapping in visual mode searches current visual selection. In both cases, the user is prompted to choose which search engine should be used. If none is given, duckduckgo is used, but this behaviour can be changed setting `g:www_default_search_engine` variable. E.g.:

    let g:www_default_search_engine = 'google'

`:Wcsearch` command and `<leader>wcs` mappings do the same but using the CLI browser.

### Shortcut search engines

Convenient shortcuts for commonly used search engines can be defined in `g:www_shortcut_engines` dictionary. Having in `vimrc`:

    let g:www_engines = {
      \ 'ruby' : 'http://ruby-doc.com/search.html?q=',
    \}

    let g:www_shortcut_engines = {
      \ 'ruby': ['Docruby', '<leader>dr', 'Doccliruby', '<leader>dcr']
    \}

automatically adds `:Docruby` / `:Doccliruby` commands, and `<leader>dr` / `<leader>dcr` mappings that work like `:Wsearch` / `:Wcsearch` and `<leader>ws` / `<leader>wcs` but using ruby straight away as search engine.

Remember that user defined commands must begin with an uppercase letter.

This is very convenient to use as a quick way to consult API documentation.

### Sessions

Arbitrary URLs and favorites can be grouped together under a name in `g:www_sessions` dictionary and opened at once using `:Wsession` command.

Having in `vimrc`:

    let g:www_urls = {
      \ 'vim' : 'http://www.vim.org',
      \ }

    let g:www_sessions = {
      \ 'dev' : ['vim', 'http://stackoverflow.com'],
      \ }

Running:

    :Wsession vim

would open `http://www.vim.org` and `http://stackoverflow.com` at once.

`:Wcsession` command does the same but using the CLI browser.

## Configuration and reference

Type `:help vim-www` for a complete reference and information about configuration.

## Bugs

Open a bug in https://github.com/waiting-for-dev/vim-www/issues

## Contributing

1. Fork the project ( http://github.com/waiting-for-dev/vim-www/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Version

vim-www follows [Semantic Versioning System 2.0](http://semver.org/). Current version is 1.0.0.

## License

The MIT Licence
http://www.opensource.org/licenses/mit-license.php

Copyright (c) 2014 Marc Busqué Pérez

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
