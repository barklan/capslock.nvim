# capslock.nvim

Software caps lock for Neovim.

Only works in insert mode. Useful in that commands, other buffers, and other applications
are unaffected or if Caps lock key is acting as another `Ctrl` or `Esc`.

## Installation

Via [packer](https://github.com/wbthomason/packer.nvim):

```lua
use("barklan/capslock.nvim")
```

## Setup

```lua
require("capslock").setup()
vim.keymap.set("i", "<C-g>c", require("capslock").toggle)
```

This maps `<C-g>c` in insert mode to toggle a temporary caps lock.
It is automatically disabled after leaving insert mode.

## Lualine integration

```lua
require("lualine").setup({
    sections = {
        lualine_x = {
            { require("capslock").status_string },
        },
    },
})
```

This will display `[CAPS LOCK]` when caps lock is active.

## Related

Inspired by tpope's [vim-capslock](https://github.com/tpope/vim-capslock) (that additionally works in normal mode).

