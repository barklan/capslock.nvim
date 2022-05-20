# capslock.nvim

Software caps lock for Neovim.

Works in normal, insert and command modes. Normal mode commands, other buffers, and other applications
are unaffected (e.g. `jk` mapped as `Escape` in insert mode will work with caps lock enabled).
Especially useful if caps lock key is acting as another `Ctrl` or `Esc`.

## Installation

Neovim 0.7.0+ required. Example via [packer](https://github.com/wbthomason/packer.nvim):

```lua
use("barklan/capslock.nvim")
```

## Setup & Usage

```lua
require("capslock").setup()
vim.keymap.set({ "i", "c", "n" }, "<C-g>c", "<Plug>CapsLockToggle")
```

This maps `<C-g>c` in insert, command and normal modes to toggle caps lock.

- When activated in insert or command mode it toggles temporary caps lock.
It is automatically disabled after leaving insert mode or command line.
- When activated in normal mode, it toggles caps lock for both normal and insert modes
(overriding insert mode caps lock state) and doesn't turn off automatically.

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

- Inspired by tpope's [vim-capslock](https://github.com/tpope/vim-capslock).
- Unicode support enabled thanks to
[ustring](https://github.com/wikimedia/mediawiki-extensions-Scribunto/tree/master/includes/engines/LuaCommon/lualib/ustring)
library.
