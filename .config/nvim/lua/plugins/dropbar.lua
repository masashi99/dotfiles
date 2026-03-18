return {
	"Bekaboo/dropbar.nvim",
	event = "BufReadPost",
  keys = {
		{
			"<leader>b",
			function()
				require("dropbar.api").pick()
			end,
		},
	},
}
