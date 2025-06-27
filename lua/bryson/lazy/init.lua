local plugins = {}

for _, mod in ipairs({
    "treesitter",
    "lsp",
    "autopairs",
    "telescope",
    "harpoon",
    "trouble",
    "fidget",
    -- "supermaven"
    "copilot",
}) do
    table.insert(plugins, require("bryson.lazy." .. mod))
end

return plugins
