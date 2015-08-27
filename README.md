# vim-www

Define your favourite websites and search engines and open them from vim. Official repository: https://github.com/waiting-for-dev/vim-www

This plugin is born out of my need to open every now and then the same documentation websites while I'm programming, of the chaos that represents keeping all of them open in browser tabs at the same time and of the mental gap saving if I can open them directly from vim.

## Installation

Just like any other vim plugin. Use [pathogen](https://github.com/tpope/vim-pathogen), [neobundle](https://github.com/Shougo/neobundle.vim) or [vundle](https://github.com/gmarik/Vundle.vim), or just [unzip](https://github.com/waiting-for-dev/vim-www/archive/master.zip) it inside your `$HOME/.vim` directory.

## Usage

`vim-www` just opens urls in your web browser. But `vim-www` understands three types of url references:

* A typical URI, e.g. http://vim.org .
* A defined plain tag. E.g., tag "vimcom" can be configured to reference http://www.vim.org/community.php .
* A defined search engine tag. E.g., tag "g?" can be configured to search in google a query that can be provided.

Tags can be configured creating the dictionary `g:www_urls` in your `.vimrc`. E.g.:

```vim
let g:www_urls = {
         \ 'vimcom' : 'http://www.vim.org/community.php',
         \ 'g?' : 'https://www.google.com/search?q=',
         \
         \ }
```

Notice that search engine tags end with a `?` character and that the search query will be appended to the defined url.

To open those urls you use the command `:Wopen`, which accepts a url reference as argument. E.g.:
    
```vim
:Wopen http://vim.org
:Wopen vimcom
:Wopen g?vim scripts
```

Above commands will open http://vim.org, http://www.vim.org/community.php urls and the resulting url of searching the string "vim scripts" in google, respectively.

If you preffer you can use `:Wopenmulti` command to open multiple urls in one step. But, please, notice that, as it is a multiple arguments command, you must scape blankspaces in the string you provide to search engines. E.g:

```vim
:Wopenmulti http://vim.org vim g?vim\ scripts
```

### Default search engine

You can also configure google or any other as your default search engine, through:

```vim
let g:www_default_search_engine = 'g?'
```

and then you can just do:

```vim
:Wsearch vim scripts
```

By default, google will be used.

### Sessions

Urls can also be grouped in sessions in the following way:

```vim
let g:www_sessions = {
         \ 'vim' : ['http://vim.org', 'vimcom', 'g?vim scripts'],
         \
         \ }
```

Then you can open in one step all referenced urls with:

```vim
:Wsession vim
```

### Mappings

There are also some convenient mappings:

* `<leader>wo` . In normal mode it will open the browser using the `WORD`  under the cursor as url reference. In visual mode it will do the same with your text selection.

* `<leader>ws` . In normal mode it will search the `WORD` under the cursor in your default search engine. In visual mode it will do the same with your text selection.

## Defaults

Some search engines are already provided by default by vim-www. Here it is the current relation:

| Tag   | Website                  |
|-------|--------------------------|
| g?    | https://google.com       |
| y?    | http://youtube.com       |
| gh?   | https://github.com       |
| bb?   | https://bitbucket.org    |
| so?   | http://stackoverflow.com |
| wiki? | http://en.wikipedia.org  |
| imdb? | http://www.imdb.com      |

Google (`g?`) is the default search engine.

You can overwrite these defaults and define new ones with `g:www_urls`.

### Configuration and reference

Type `:help vim-www` for a complete reference and information about configuration.

### BUGS

Open a bug in https://github.com/waiting-for-dev/vim-www/issues

### Contributing

1. Fork the project ( http://github.com/waiting-for-dev/vim-www/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Version

vim-www follows [Semantic Versioning System 2.0](http://semver.org/). Current version is 0.0.4.

### License

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
