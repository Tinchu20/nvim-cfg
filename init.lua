require('config.settings')
require('config.lazy')

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, save_cursor)
  end,
})

-- Clear the command area after 3 seconds
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_echo({{""}}, false, {})
    end, 3000)  -- 3000 ms = 3 seconds
  end
})

-- Clear highlights when pressing <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true, noremap = true })



vim.o.completeopt = "menu,menuone,noselect"
vim.o.complete = ".,w,b,u,t"

vim.api.nvim_set_hl(0, "Comment", { fg = "#6A9955", italic = true })
