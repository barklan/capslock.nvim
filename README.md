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
vim.keymap.set("i", "<C-l>", "<Plug>CapsLockToggle")
```

This maps `<C-g>c` in insert, command and normal modes and `<C-l>` in insert mode to toggle caps lock.

- When activated in insert or command mode it toggles temporary caps lock.
  It is automatically disabled after leaving insert mode or command line.
- When activated in normal mode, it toggles caps lock for both normal and insert modes
  and doesn't turn off automatically.

## Statusline integration

Use `require("capslock").status_string` function as a status line component to
display `[CAPS LOCK]` when caps lock is active.

### lualine

```lua
require("lualine").setup({
    sections = {
        lualine_x = {
            { require("capslock").status_string },
        },
    },
})
```

### feline

Set the function above as a `provider` in status line component.

## Related

- Inspired by tpope's [vim-capslock](https://github.com/tpope/vim-capslock).
- Unicode support enabled thanks to
  [ustring](https://github.com/wikimedia/mediawiki-extensions-Scribunto/tree/master/includes/engines/LuaCommon/lualib/ustring)
  library.
