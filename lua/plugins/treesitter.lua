--[[
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter")
        config.setup({
            --ensure_installed = {"asm", "bash", "c", "cpp", "lua", "make", "vim"},
            auto_install = true,
            highlight = {enable = true},
            indent = {enable = true},
        })
    end
}
]]

--[[

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        local ts = require("nvim-treesitter")

        vim.filetype.add({
            extension = {
                slint = "slint",
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                local lang = vim.treesitter.language.get_lang(ft)

                if not lang then
                    return
                end

                ts.install({ lang }):wait(30000)

                if vim.api.nvim_buf_is_valid(args.buf) then
                    pcall(vim.treesitter.start, args.buf, lang)
                end
            end,
        })
    end,
}
]]

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",

    config = function()
        local ts = require("nvim-treesitter")

        vim.filetype.add({
            extension = {
                slint = "slint",
            },
        })

        -- Install these once.
        ts.install({
            "asm",
            "bash",
            "c",
            "cpp",
            "lua",
            "make",
            "vim",
            "rust",
            "slint",
        })

        -- Start Treesitter when entering a supported filetype.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                local lang = vim.treesitter.language.get_lang(ft)

                if not lang then
                    return
                end

                if vim.api.nvim_buf_is_valid(args.buf) then
                    pcall(vim.treesitter.start, args.buf, lang)
                end
            end,
        })
    end,
}
