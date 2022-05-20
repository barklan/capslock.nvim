local M = {}

M.capslock = "capslock"
M.status_string_const = "[CAPS LOCK]"
M.keybinding_const = "<Plug>CapsLockToggle"

M.ustring = require("capslock.ustring.ustring")

M.enable = function(mode)
    vim.api.nvim_buf_set_var(0, M.capslock .. mode, M.capslock)
    if mode == "c" then
        local i = string.byte("A")
        while i <= string.byte("Z") do
            vim.keymap.set(mode, string.char(i), string.char(i + 32), { buffer = true })
            vim.keymap.set(mode, string.char(i + 32), string.char(i), { buffer = true })
            i = i + 1
        end
        vim.cmd("redraws")
    end
end

M.disable = function(mode)
    vim.api.nvim_buf_del_var(0, M.capslock .. mode)
    if mode == "c" then
        local i = string.byte("A")
        while i <= string.byte("Z") do
            vim.keymap.del(mode, string.char(i), { buffer = true })
            vim.keymap.del(mode, string.char(i + 32), { buffer = true })
            i = i + 1
        end
    end
end

M.enabled = function(mode)
    local status, val = pcall(vim.api.nvim_buf_get_var, 0, M.capslock .. mode)
    if status == true and val == M.capslock then
        return true
    end
    return false
end

M.toggle = function(mode)
    if mode == nil then -- To avoid breaking change.
        mode = "i"
    end
    if M.enabled(mode) then
        return M.disable(mode)
    else
        return M.enable(mode)
    end
end

M.exitcallback_insert = function()
    if M.enabled("i") then
        M.disable("i")
    end
end

M.exitcallback_cmd = function()
    if M.enabled("c") then
        M.disable("c")
    end
end

M.insert_upper = function()
    if M.enabled("i") or M.enabled("n") then
        local char = vim.v.char
        local lower = M.ustring.lower(char)
        if char == lower then
            vim.v.char = M.ustring.upper(char)
        else
            vim.v.char = lower
        end
    end
end

M.status_string = function()
    local modes = { "n", "i", "c" }
    for _, mode in ipairs(modes) do
        if M.enabled(mode) then
            return M.status_string_const
        end
    end
    return ""
end

M.setup = function()
    vim.keymap.set("n", M.keybinding_const, function() M.toggle("n") end, { silent = true })
    vim.keymap.set("i", M.keybinding_const, function() M.toggle("i") end, { silent = true })
    vim.keymap.set("c", M.keybinding_const, function() M.toggle("c") end, { silent = true })

    vim.api.nvim_create_augroup(M.capslock, { clear = true })
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = M.capslock,
        callback = M.exitcallback_insert,
    })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
        group = M.capslock,
        callback = M.exitcallback_cmd,
    })
    vim.api.nvim_create_autocmd("InsertCharPre", {
        group = M.capslock,
        callback = M.insert_upper,
    })
end

return M
