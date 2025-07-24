require("bryson.set")
require("bryson.lazy_init")
require("bryson.remap")

local augroup = vim.api.nvim_create_augroup
local group = augroup('group', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})


autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd('LspAttach', {
    group = group,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "K", function()
            local base_win_id = vim.api.nvim_get_current_win()
            local windows = vim.api.nvim_tabpage_list_wins(0)
            for _, win_id in ipairs(windows) do
                if win_id ~= base_win_id then
                    local win_cfg = vim.api.nvim_win_get_config(win_id)
                    if win_cfg.relative == "win" and win_cfg.win == base_win_id then
                        vim.api.nvim_win_close(win_id, {})
                        return
                    end
                end
            end
            vim.lsp.buf.hover()
        end, { remap = false, silent = true, buffer = e.buf, desc = "Toggle hover" })
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash", "c", "cpp", "css", "dockerfile", "go", "html", "javascript",
        "json", "lua", "markdown", "python", "rust", "typescript", "vim",
        "yaml"
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
})

-- vim.cmd([[
--   autocmd FileType html setlocal filetype=html.javascript
-- ]])

vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        spacing = 2,
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
