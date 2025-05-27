local M = {}

local function send_to_tmux(text)
    -- Ensure the text is sanitized
    if text then
        text = text:gsub("'", "'\\''")
        os.execute("tmux send-keys -t :.+ '" .. text .. "' Enter")
    end
end

-- Send current line
function M.send_current_line()
    local line = vim.api.nvim_get_current_line()
    send_to_tmux(line)
end

-- Send text with motion
function M.send_text_with_motion(type)
    -- type is in ["line", "char", "block"]

    -- push reg a:
    local former_reg_a = vim.fn.getreg("a")

    -- select from marker '[ to marker '] into register a:
    if type == 'line' then
        -- line-wise:
        vim.api.nvim_exec("normal! '[V']" .. '"ay', false)
    elseif type == 'char' then
        -- character-wise:
        vim.api.nvim_exec("normal! '[v']" .. '"ay', false)
    else
        print('send2tmux.send_text_with_motion does not support block motions')
    end

    send_to_tmux(vim.fn.getreg("a"))

    -- pop reg a:
    vim.fn.setreg("a", former_reg_a)
end

-- Send selected text
function M.send_selection()
    -- push reg a:
    local former_reg_a = vim.fn.getreg("a")

    -- yank selection into register a:
    vim.api.nvim_exec('normal! "ay', false)

    -- and send it to tmux:
    send_to_tmux(vim.fn.getreg("a"))

    -- pop reg a:
    vim.fn.setreg("a", former_reg_a)
end

return M
