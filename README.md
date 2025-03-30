# capslock.nvim

Software caps lock for Neovim.

Works in normal, insert and command modes. Normal mode commands, other buffers, and other applications
are unaffected (e.g. `jk` mapped as `Escape` in insert mode will work with caps lock enabled).
Especially useful if caps lock key is acting as another `Ctrl` or `Esc`.

## Installation

Neovim 0.7.0+ required. Example via [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "barklan/capslock.nvim",
    lazy = true,
    keys = {
        { "<C-l>", "<Plug>CapsLockToggle", mode = { "i", "c" } },
        { "<leader>c", "<Plug>CapsLockToggle", mode = { "n" } },
    },
    config = true,
},
```

## Usage

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
