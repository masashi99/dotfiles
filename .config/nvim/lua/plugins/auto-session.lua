return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		auto_save = true,
		auto_restore = true,
		args_allow_single_directory = true,
		git_use_branch_name = false,
		close_unsupported_windows = true,
		bypass_save_filetypes = { "snacks_dashboard" },
		post_restore_cmds = {
			function()
				vim.schedule(function()
					if package.loaded["snacks"] then
						Snacks.explorer.open()
					end
				end)
			end,
		},
	},
}
