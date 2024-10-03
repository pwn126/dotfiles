local utils = {}

function utils.toggleIndentation()
    local title = "Toggle Indentation"

    if vim.opt.expandtab:get() then
        vim.opt.expandtab = false
        vim.notify("Using TABS for indentation", "info", { title = title })
    else
        vim.opt.expandtab = true
        vim.notify("Using SPACES for indentation", "info", { title = title })
    end
end

function utils.toggleQuickfixWindow()
    -- 1 == normal window; 0 == popup window
    local cur_winid = vim.fn.winnr("$")

    if cur_winid == 1 then
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
end

function utils.toggleLineNumbers()
    if vim.opt.number:get() and vim.opt.relativenumber:get() then
        vim.opt.relativenumber = false
    elseif vim.opt.number:get() and not vim.opt.relativenumber:get() then
        vim.opt.number = false
    else
        vim.opt.number = true
        vim.opt.relativenumber = true
    end

    vim.notify(
        string.format("Line Numbers: %s\nRelative Numbers: %s",
            vim.opt.number:get(),
            vim.opt.relativenumber:get()),
        "info",
        { title = "Toggle Line Numbers" }
    )
end

function utils.isempty(s)
    return s == nil or s == ""
end

function utils.get_buf_option(opt)
    local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
    if not status_ok then
        return nil
    else
        return buf_option
    end
end

return utils
