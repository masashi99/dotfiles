return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~_" },
			},
			current_line_blame = true,
		},
    keys = {
       {
        "<leader>gd",
        function()
          if vim.wo.diff then
            -- diff中ならOFF
            vim.cmd("diffoff")
            vim.cmd("close")
          else
            -- diffじゃなければON
            require("gitsigns").diffthis()
          end
        end,
        desc = "toggle diff",
        mode = { "n" },
      },
      {
        "<leader>gr",
        function()
          local gitsigns = require("gitsigns")

          if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
            local start_line = vim.fn.line("v")
            local end_line = vim.fn.line(".")

            if start_line > end_line then
              start_line, end_line = end_line, start_line
            end

            gitsigns.reset_hunk({ start_line, end_line })
            vim.cmd("normal! <Esc>")
            return
          end

          gitsigns.reset_hunk()
        end,
        desc = "reset hunk",
        mode = { "n", "v" },
      },
      {
        "<leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "reset buffer",
        mode = { "n" },
      },
    },
	},
}
