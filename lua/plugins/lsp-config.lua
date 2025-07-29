return {
    {
        --"williamboman/mason.nvim",
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {"neovim/nvim-lspconfig"},
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    --"bashls",       -- Bash
                    "clangd",       -- C/C++
                    "lua_ls",       -- Lua
                    --"pyright",      -- Python
                    --"rust_analyzer",-- Rust
                    --"vimls",        -- Vimscript
                    --"asm_lsp",      -- Assembly (x86/ARM)
                },
            })
        end
    },
    -- LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Configure clangd for C/C++ (embedded-friendly)
      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--query-driver=/usr/bin/gcc", -- Adjust for ARM/AVR-GCC if needed
        },
        filetypes = { "c", "cpp" },
        --root_dir = lspconfig.util.root_pattern(
          --"compile_commands.json", -- Highest priority
          --"Makefile",
          --"CMakeLists.txt"
        --),
        init_options = {
          fallbackFlags = {
            --"-I/usr/include",
            --"-I/usr/local/include",
            --"-I./include",
            "-Wall",
          },
        },
      })

      -- Keymaps for LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          -- Go to definition (gd)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- Find references (gr)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          -- Hover docs (K)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- Restart LSP if headers change
          vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts)
        end,
      })
    end,
    },
    -- Autocompletion (optional)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }),
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
            })
        end,
    },
}
