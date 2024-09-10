return {
    "rose-pine/neovim",
    as = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("rose-pine")

        local groups = {
            "Normal",
            "NormalFloat"
        }
        for i = 1, #groups do
            vim.api.nvim_set_hl(0, groups[i], { bg = "none" })
        end
    end,
    opts = {},
}
