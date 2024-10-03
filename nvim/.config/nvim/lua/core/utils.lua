local utils = {}

function utils.toggleIndentation()
    local title = "Toggle Indentation"

    if vim.o.expandtab then
        vim.opt.expandtab = false
        vim.notify("Using TABS for indentation", vim.log.levels.INFO, { title = title })
    else
        vim.opt.expandtab = true
        vim.notify("Using SPACES for indentation", vim.log.levels.INFO, { title = title })
    end
end

function utils.toggleQuickfixWindow()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win["quickfix"] == 1 then
            vim.cmd("botright cclose")
            return
        end
    end
    vim.cmd("botright copen")
end

function utils.toggleSpellChecking()
    vim.opt.spell = not (vim.opt.spell:get())
    if vim.opt.spell:get() then
        vim.notify("Spelling enabled", vim.log.levels.INFO)
    else
        vim.notify("Spelling disabled", vim.log.levels.INFO)
    end
end

function utils.toggleLineNumbers()
    if vim.o.number and vim.o.relativenumber then
        vim.opt.relativenumber = false
    elseif vim.o.number and not vim.o.relativenumber then
        vim.opt.number = false
    else
        vim.opt.number = true
        vim.opt.relativenumber = true
    end

    vim.notify(
        string.format("Line Numbers: %s\nRelative Numbers: %s", vim.o.number, vim.o.relativenumber),
        vim.log.levels.INFO,
        { title = "Toggle Line Numbers" }
    )
end

function utils.toggleDiagnostics(global)
    local vars, bufnr, cmd

    if global then
        vars = vim.g
        bufnr = nil
    else
        vars = vim.b
        bufnr = 0
    end

    vars.diagnostics_disabled = not vars.diagnostics_disabled
    if vars.diagnostics_disabled then
        cmd = "disable"
        vim.notify("Diagnostics disabled", vim.log.levels.INFO)
    else
        cmd = "enable"
        vim.notify("Diagnostics enabled", vim.log.levels.INFO)
    end

    vim.diagnostic[cmd](bufnr)
end

function utils.toggleInlayHints()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
        { bufnr = bufnr }
    )
end

return utils
