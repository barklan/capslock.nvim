local M = {}

M.capslock = "capslock"

M.enable = function()
    vim.api.nvim_buf_set_var(0, M.capslock, true)
end

M.disable = function()
    vim.api.nvim_buf_del_var(0, M.capslock)
end

M.enabled = function()
    return vim.b.capslock
end

M.toggle = function()
    if M.enabled() then
        print("caps lock disabled")
        return M.disable()
    else
        print("caps lock enabled")
        return M.enable()
    end
end

M.exitcallback = function()
    if M.enabled() then
        M.disable()
    end
end

M.insert_upper = function()
    if M.enabled() == true then
        if vim.v.char == string.lower(vim.v.char) then
            vim.v.char = string.upper(vim.v.char)
        else
            vim.v.char = string.lower(vim.v.char)
        end
    end
end

M.status_string = function()
    if M.enabled() == true then
        return "[CAPS LOCK]"
    end
    return ""
end

M.setup = function()
    vim.api.nvim_create_augroup(M.capslock, { clear = true })
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = M.capslock,
        callback = M.exitcallback,
    })
    vim.api.nvim_create_autocmd("InsertCharPre", {
        group = M.capslock,
        callback = M.insert_upper,
    })
end

return M
