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
          require("gitsigns").reset_hunk()
        end,
        desc = "reset hunk",
        mode = { "n" },
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
