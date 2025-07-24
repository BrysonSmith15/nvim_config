vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.g.mapleader = " "
-- require("bryson.lazy.colors")
-- require("bryson.lazy.treesitter")
--

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>yy", [[0v$"+y]]) -- copy full line to clipboard
vim.keymap.set("v", "<leader>y", [["+y]])     -- copy selected text to clipboard
vim.keymap.set("n", "<leader>p", [["+p]])

-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
    print("Sourced")
end)

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files) --, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep)  --, { desc = 'Telescope live grep' })

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set('i', '<C-CR>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
-- vim.g.copilot_no_tab_map = true
