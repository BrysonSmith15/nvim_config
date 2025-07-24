-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = "bryson.lazy",
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "darkside" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
    plugins = {
        { 'pedropmedina/darkside',           dependencies = { 'rktjmp/lush.nvim' } },
        {
            "mason-org/mason.nvim",
            opts = {}
        },
        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            config = true
            -- use opts = {} for passing setup options
            -- this is equivalent to setup({}) function
        },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        {
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require("trouble").setup({
                    position = "bottom",
                    height = 10,
                    use_diagnostic_signs = true,
                })
            end,
            opts = {
                modes = {
                    diagnostics_buffer = {
                        mode = "diagnostics", -- inherit from diagnostics mode
                        filter = { buf = 0 }, -- filter diagnostics to the current buffer
                    },
                }
            },
            cmd = "Trouble",
            keys = {
                {
                    "<leader>xx",
                    "<cmd>Trouble diagnostics toggle<cr>",
                    desc = "Diagnostics (Trouble)",
                },
                {
                    "<leader>xX",
                    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                    desc = "Buffer Diagnostics (Trouble)",
                },
                {
                    "<leader>cs",
                    "<cmd>Trouble symbols toggle focus=false<cr>",
                    desc = "Symbols (Trouble)",
                },
                {
                    "<leader>cl",
                    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                    desc = "LSP Definitions / references / ... (Trouble)",
                },
                {
                    "<leader>xL",
                    "<cmd>Trouble loclist toggle<cr>",
                    desc = "Location List (Trouble)",
                },
                {
                    "<leader>xQ",
                    "<cmd>Trouble qflist toggle<cr>",
                    desc = "Quickfix List (Trouble)",
                },
            },
            -- {
            --     "supermaven-inc/supermaven-nvim",
            --     config = function()
            --         require("supermaven-nvim").setup({})
            --     end,
            -- },

        },
        {
            "j-hui/fidget.nvim",
            -- opts = {
            --     -- options
            -- },
        },
        { "github/copilot.vim" },
        { "nvim-treesitter/nvim-treesitter", branch = 'master',                    lazy = false, build = ":TSUpdate" }
    }
})
