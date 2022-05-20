local M = {}

M.capslock = "capslock"

M.ustring = require("capslock.ustring.ustring")

M.enable = function(mode)
    vim.api.nvim_buf_set_var(0, M.capslock .. mode, true)
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
    -- vim.api.nvim_buf_get_var(0, M.capslock .. mode) panics if var is not set
    if mode == "n" then
        return vim.b.capslockn
    elseif mode == "i" then
        return vim.b.capslocki
    elseif mode == "c" then
        return vim.b.capslockc
    end
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
    modes = { "n", "i", "c" }
    for _, mode in ipairs(modes) do
        if M.enabled(mode) then
            return "[CAPS LOCK]"
        end
    end
    return ""
end

M.setup = function()
    vim.keymap.set("n", "<Plug>CapsLockToggle", function() M.toggle("n") end, { silent = true })
    vim.keymap.set("i", "<Plug>CapsLockToggle", function() M.toggle("i") end, { silent = true })
    vim.keymap.set("c", "<Plug>CapsLockToggle", function() M.toggle("c") end, { silent = true })

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
