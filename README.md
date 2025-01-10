# `idado.nvim`

This is a pretty simple neovim plugin, for managing image files specifically in `markdown` environments.

https://github.com/user-attachments/assets/8b7eaf7f-a2d5-4f98-bd08-dcd448d4c0b6

## Usage

Either copy a filepath or drag&drop a file into the current buffer in an empty line. For example:

```
/Users/breiting/Downloads/1735476340670.jpeg
```

Put the cursor to this line and execute `:ProcessImage`. This will copy over the source file into the
specified `target_path` while renaming it to the given file pattern and replaces the content to
a proper markdown image directive:

```
![2025-01-10_11-52-11.png](/Users/breiting/Documents/images/2025-01-10_11-52-11.png)
```

This is specifically useful, if you write `markdown` files, and would like to integrate images
from external sources.

## Installation

Please use your favorite plugin manager, I am using `lazy.vim` with the following configuration.
All `config` parameters are optional, and are initialized with defaults.

```
return {
  {
    "breiting/idado.nvim",
    config = function()
      local idado = require("idado")
      idado.config.target_path = "~/Documents/images/"
      idado.config.pattern = "%Y-%m-%d_%H-%M-%S"
    end,
  },
}
```
