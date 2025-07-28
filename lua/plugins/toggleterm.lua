return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "rounded",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.7),
        row = math.floor(vim.o.lines * 0.15),
        col = math.floor(vim.o.columns * 0.1),
        winblend = 0, -- fully opaque
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "rounded",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.7),
        row = math.floor(vim.o.lines * 0.15),
        col = math.floor(vim.o.columns * 0.1),
        winblend = 0, -- fully opaque
      },
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>gg", _lazygit_toggle, { desc = "Toggle LazyGit" })
  end,
}

