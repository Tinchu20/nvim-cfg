-- ~/.config/nvim/lua/config/lsp.lua
-- Pure Neovim 0.11 LSP config — no nvim-lspconfig involved at all

-- Give every server nvim-cmp's extended capabilities
vim.lsp.config("*", {
    capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    ),
})

-- ── C / C++ via clangd ──────────────────────────────────────────────────────
vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--query-driver=/usr/bin/gcc,/usr/bin/g++",
    },
    filetypes    = { "c", "cpp", "objc", "objcpp" },
    root_markers = {
        "compile_commands.json",   -- MUST exist at project root
        ".clangd",
        "Makefile",
        "CMakeLists.txt",
        ".git",
    },
    init_options = { fallbackFlags = { "-Wall" } },
})
vim.lsp.enable("clangd")

-- ── Lua ─────────────────────────────────────────────────────────────────────
vim.lsp.config("lua_ls", {
    settings = {
        Lua = { diagnostics = { globals = { "vim" } } },
    },
})
vim.lsp.enable("lua_ls")

-- ── Keymaps (only when LSP attaches to a buffer) ────────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local o = { buffer = args.buf }
        vim.keymap.set("n", "gd",         vim.lsp.buf.definition,     o)
        vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,    o)
        vim.keymap.set("n", "gr",         vim.lsp.buf.references,     o)
        vim.keymap.set("n", "gi",         vim.lsp.buf.implementation, o)
        vim.keymap.set("n", "K",          vim.lsp.buf.hover,          o)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,         o)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,    o)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, o)
        vim.keymap.set("n", "<leader>d",  vim.diagnostic.open_float,  o)
        vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev,   o)
        vim.keymap.set("n", "]d",         vim.diagnostic.goto_next,   o)
        vim.keymap.set("n", "<A-o>",      "<cmd>ClangdSwitchSourceHeader<CR>", o)
        vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>",      o)
    end,
})
