# capslock.nvim

Software caps lock for Neovim.

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
