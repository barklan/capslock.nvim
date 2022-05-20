# capslock.nvim

Software caps lock for Neovim.

Only works in insert mode. Useful in that commands, other buffers, and other applications
are unaffected or if Caps lock key is acting as another `Ctrl` or `Esc`.

## Install

Via packer:

```lua
use("barklan/capslock.nvim")
```

## Setup

```lua
require("capslock").setup()
vim.keymap.set("i", "<C-g>c", require("capslock").toggle)
```

Above maps `<C-g>c` in insert mode to toggle a temporary software caps lock.
Caps lock is automatically disabled after leaving insert mode.
