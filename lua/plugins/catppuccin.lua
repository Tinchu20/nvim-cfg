--[[
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000 ,
    config = function()
        vim.cmd.colorscheme "catppuccin"
    end
}

--]]


return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            custom_highlights = function(colors)
                return {
                    LspInlayHint = {
                        fg = colors.overlay1,
                        bg = "NONE",
                    },
                }
            end,
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}
