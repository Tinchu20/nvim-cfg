return {
    -- Mason: UI to install LSP servers  (:Mason to open)
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    -- mason-lspconfig: auto-installs servers via Mason
    -- NOTE: only used for installation — NOT for configuration
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls" },
            })
        end
    },

    -- nvim-cmp capabilities helper (no lspconfig needed on Nvim 0.11)
    { "hrsh7th/cmp-nvim-lsp" },

    -- Pure Nvim 0.11 LSP setup — no nvim-lspconfig at all
    -- vim.lsp.config() + vim.lsp.enable() is the native API now
    {
        "neovim/nvim-lspconfig",   -- kept ONLY so mason-lspconfig can find server paths
        lazy = true,               -- never runs its own config
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp     = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                snippet = { expand = function(a) luasnip.lsp_expand(a.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"]     = cmp.mapping.select_next_item(),
                    ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, { name = "luasnip" },
                    { name = "buffer" },   { name = "path" },
                }),
                formatting = {
                    format = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 }),
                },
            })
        end,
    },
}






























